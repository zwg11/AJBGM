//
//  BLEViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/7.
//  Copyright © 2019 apple. All rights reserved.
//

//  2019/08/16
//  使用 CoreBluetooth 进行血糖仪蓝牙连接取数据
//  已完成内容：蓝牙数据的传输
//  未完成内容：显示数据界面、加载动画、与服务器的通信、

// *********2019/08/18***************
// 发现程序结束后各个变量中的内容未置空，
// 如再次传输会有意想不到的结果
// 建议传输结束后原来的所有存储数据的变量都置空
// 置空对象有 BLEglucoseDate glucoseValue deviceName deviceDic dataSting

// ************2019/08/19************
// 动画效果规划如下：
// 点击单元格连接相应设备，弹出加载视图
// 加载视图会显示 当前连接状态 的相关信息，以文本形式显示
// 如数据传输成功并且 CRC校验码 无误，则提示数据传输完成，跳转到其他界面显示数据
// 之间如h有任何错误导致得不到血糖数据都以 警示窗 的形式弹出相应原因

import UIKit
import CoreBluetooth
import Alamofire
import HandyJSON

// 需要用的服务的 CBUUID
let glucoseDevServiceCBUUID = CBUUID(string: "C14D2C0A-401F-B7A9-841F-E2E93B80F631")

/*
 Obtain the Bluetooth permission of the device to connect to ble to transfer data
 */

class BLEViewController: UIViewController ,CBCentralManagerDelegate,
CBPeripheralDelegate,UITableViewDelegate,UITableViewDataSource{
    
    // 存储读取的数据中的血糖记录的时间
    var BLEglucoseDate:[String] = []
    // 存取读取的数据中的血糖值
    var BLEglucoseValue:[Int] = []
    // 存储读取的数据中的血糖标志位
    var BLEglucoseMark:[Int] = []
    // 计时器
    var second = 10
    var second1 = 10
    var timer : Timer?
    var timer1 : Timer?
    // MARK: - 表格初始化
    // 表格行数设置
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceDic.count
    }
    
    // 表格内容设置
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "id")
        
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "id")
        }
        //        let uuid = deviceDic[indexPath.row].description
        //cell?.textLabel?.text = deviceName[indexPath.row]
        cell?.selectionStyle = .none
        cell?.textLabel?.text = deviceName[indexPath.row]
        cell?.textLabel?.textColor = UIColor.white
        //        cell?.detailTextLabel?.text = uuid
        //        cell?.detailTextLabel?.textColor = UIColor.lightGray
        cell?.accessoryType = .disclosureIndicator
        //        cell?.backgroundColor = ThemeColor
        cell?.backgroundColor = UIColor.clear
        return cell!
    }
    // 设置表格头部背景颜色
    //    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    ////        guard let header = view as? UITableViewHeaderFooterView else {return}
    ////        header.textLabel?.textColor = UIColor.white
    ////        view.tintColor = UIColor.clear
    ////        view.layer.borderColor = UIColor.white.cgColor
    //        let header = view as? UITableViewHeaderFooterView
    //        //        view.tintColor = UIColor.white
    //        header?.backgroundColor = UIColor.clear
    //        header?.textLabel?.textColor = UIColor.white
    //        header?.textLabel?.text = "Data in Glucose Meter"
    //
    //    }
    // 表格头部信息
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return "Connected Glucose Meter"
    //    }
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 44
    //    }
    
    // 点击单元格连接相应的设备
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 连接设备
        //connectDeviceWithPerioheral(connect: peripherals[indexPath.row])
        self.centralManager?.connect(peripherals[indexPath.row], options: nil)
        //显示 ”加载“ 视图,加载图片旋转，且显示状态文字标签
        loadV.startIndicator()
        // 使得风火轮视图全屏显示
        //        UIApplication.shared.keyWindow?.addSubview(loadV)
        self.navigationController?.view.addSubview(loadV)
        //        self.view.addSubview(loadV)
        loadV.setLabelText("Connecting ...")
        startTimer()
    }
    
    private var meterType:Int = 14
    private var byteDate:Data?
    private var tableView = UITableView()
    // 记录扫描到的设备的UUID
    private var deviceDic:Array<UUID> = []
    // 记录扫描到的设备名称
    private var deviceName:Array<String> = []
    // 记录扫描到的设备
    private var peripherals:Array<CBPeripheral> = []
    // 记录返回的仪器ID
    private var meterID:String = ""
    // 最新血糖记录
    private var lastRecord = ""
    // 所要返回的数据量
    private var dataCount = 0
    // 第几个数据
    private var dataOrder = 0
    // 记录所要用到的所有 特征值
    //    private var characters:[CBCharacteristic] = []
    
    // 记录有 .read 和 .notify 的 特征值
    private var readCharacteristic:CBCharacteristic?
    // 记录有 .write 特征值
    private var writeCharacteristic:CBCharacteristic?
    // 是否为第一个血糖数据
    private var isFirstRecord = true
    // 中心设备管理对象
    private var centralManager:CBCentralManager?
    // 要连接的外设
    //    private var myperipheral:CBPeripheral?
    // 要交互的外设属性
    //    private var characteristic:CBCharacteristic?
    
    // 以int型存储要传过来的血糖数据以便使用CRC验证码验证
    private var dataSting:[Int] = []
    
    // 监听中心设备蓝牙状况
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("unknown.")
            
        case .resetting:
            print("resetting..")
            
        case .unsupported:
            print("unsurpported")
            
        case .unauthorized:
            print("unauthorized..")
            
        case .poweredOff:
            print("powered off..")
            //            let alert = CustomAlertController()
            //            alert.custom(self, "", "请开启蓝牙")
            
        case .poweredOn:
            // 若蓝牙打开了，搜索设备
            print("powered on..")
            self.centralManager?.scanForPeripherals(withServices: [glucoseDevServiceCBUUID])
            // 进行计时
            startScanTimer()
            break
        default:
            print("unknown state error..")
            break
        }
    }
    
    
    // MARK: - 发现设备
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !deviceDic.contains(peripheral.identifier){
            
            print("设备\(peripheral.name ?? "unknown\(deviceName.count-1)")" )
            print(peripheral.identifier)
            
            // 将 设备名称、设备ID 和 设备实体 加入相应的数组，为列表的显示和动作做准备
            deviceName.append(peripheral.name ?? "unknown\(deviceName.count)")
            deviceDic.append(peripheral.identifier)
            peripherals.append(peripheral)
            
            self.tableView.reloadData()
            print(deviceDic.count)
        }
        
    }
    //  MARK: - 连接设备
    func connectDeviceWithPerioheral(connect peripheral:CBPeripheral){
        self.centralManager?.connect(peripheral, options: nil)
    }
    //  MARK: - 连接设备后
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        //原来
        if timer != nil{
            timer!.invalidate() //销毁timer
            timer = nil
        }
        //         停止扫描
        //        central.stopScan()
        stopScanTimer()
        print("connnected success!!")
//        logUpload("connnected success!!")
        
        // 设置外设代理，并记录连接的外设对象
        peripheral.delegate = self
        //        self.myperipheral = peripheral
        peripheral.discoverServices([glucoseDevServiceCBUUID])
        //peripheral.discoverServices("需要用的服务UUID")
        
    }
    
    // MARK: - 连接设备失败时回调的方法
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
//        self.logUpload("连接失败")
        loadV.stopIndicator()
        let x = UIAlertController(title: "", message: "Connecting Failed", preferredStyle: .alert)
        self.present(x, animated: true, completion: {()->Void in
            sleep(1)
            x.dismiss(animated: true, completion: {
            })
        })
    }
    
    // 断开连接时回调的方法
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
//        self.logUpload("断开连接")
        loadV.stopIndicator()
        let x = UIAlertController(title: "", message: "Disconnected", preferredStyle: .alert)
        self.present(x, animated: true, completion: {()->Void in
            sleep(1)
            x.dismiss(animated: true, completion: {
            })
        })
    }
    
    //  MARK: - 发现设备的服务后的回调方法
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        // 失败时输出对应的错误
        if ((error) != nil){
//            self.logUpload("查找services时\(peripheral.name!)报错\(String(describing: error?.localizedDescription))")
        }
        else{
            for i:CBService in peripheral.services!{
//                self.logUpload("外设中有服务:\(i.uuid)")
//                self.logUpload("service：\(i)")
                // 连接相应的服务
                if i.uuid.isEqual(CBUUID(string: "C14D2C0A-401F-B7A9-841F-E2E93B80F631"))
                {
                    // 发现服务的特征值
                    peripheral.discoverCharacteristics(nil, for: i)
//                    logUpload("连接了C14D2C0A-401F-B7A9-841F-E2E93B80F631服务")
                    print("连接了C14D2C0A-401F-B7A9-841F-E2E93B80F631服务")
                }
            }
        }
    }
    //  MARK: - 发现特征值成功
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("发现特征值成功")
//        logUpload("发现特征值成功")
        var isSetNotify = false
        var isWrite = false
        for characteristic in service.characteristics!{
            //            self.characters.append(characteristic)
            //            if characteristic.uuid.isEqual(CBUUID(string: "81EB77BD-89B8-4494-8A09-7F83D986DDC7")){
            //            if characteristic.uuid.isEqual(CBUUID(string: "2A4D")){
            //
            //                // 如果properties 为 write，向特征值发送命令
            //                // 属性必须是 withoutResponse
            //                if characteristic.properties.contains(.writeWithoutResponse){
            //                    print("\(characteristic.uuid)'s properties contains .writeWithoutResponse")
            //
            //                    print("写数据")
            //                    self.writeCharacteristic = characteristic
            //                    // 此处 byteDate 不一定是&T1 62558，后续处理
            //                    peripheral.writeValue(byteDate!, for: characteristic, type: .withoutResponse)
            //                }// 如果properties 为 read notify，订阅特征值
            //                else if characteristic.properties.contains(.read){
            //                    if characteristic.properties.contains(.notify){
            //                        print("监听特征值")
            //                        peripheral.setNotifyValue(true, for: characteristic)
            //                        print("\(characteristic.uuid)'s properties contains .read and .notify")
            //                        self.readCharacteristic = characteristic
            //                        isSetNotify = true
            //                    }
            //                }
            //            }// if isEqual end
            //            如果properties 为 write，向特征值发送命令
            // 属性必须是 withoutResponse
            if !isWrite{
                if characteristic.properties.contains(.writeWithoutResponse){
                    print("\(characteristic.uuid)'s properties contains .writeWithoutResponse")
                    
                    print("写数据")
                    self.writeCharacteristic = characteristic
                    // 此处 byteDate 不一定是&T1 62558，后续处理
                    peripheral.writeValue(byteDate!, for: characteristic, type: .withoutResponse)
                    isWrite = true
                }
            }
            if !isSetNotify{
                // 如果properties 为 read notify，订阅特征值
                if characteristic.properties.contains(.read){
                    if characteristic.properties.contains(.notify){
                        print("监听特征值")
                        peripheral.setNotifyValue(true, for: characteristic)
                        
                        print("\(characteristic.uuid)'s properties contains .read and .notify")
                        self.readCharacteristic = characteristic
                        isSetNotify = true
                    }
                }
            }
            
        }// for end
        if !isSetNotify || !isWrite{
            loadV.stopIndicator()
            //            loadV.removeFromSuperview()
            print("连接失败")
        }
    }
    
    // 当外围设备收到启动或停止为指定特征值提供通知的请求时调用。
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        
    }
    
    //  MARK: - 所监听的特征值更新时的回调方法
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        let crc = CRC16()
        
        if(error) != nil{
            let ERROR_INFO = String(describing: error?.localizedDescription)
            print(ERROR_INFO)
//            self.logUpload("ERROR:" + ERROR_INFO)
            self.loadV.stopIndicator()
            self.initAllDate()
            let alert = CustomAlertController()
            alert.custom(self, "ERROR", ERROR_INFO)
        }else{
            //print("特征值：\(characteristic)")
            //print("特征值的value：\(characteristic.value!)")
            // 记录错误信息
            var wrongInfo:String?
            // 在主程序中刷新
            DispatchQueue.main.async {
                print("收到数据")
                if characteristic.value != nil{
//                    self.logUpload("收到数据:\(String(data: characteristic.value!, encoding: .utf8) ?? "nothing")")
                }else{
//                    self.logUpload("收到的数据为nil，不明原因")
                    self.loadV.stopIndicator()
                    self.initAllDate()
                    let alert = CustomAlertController()
                    alert.custom(self, "ERROR", "unknown error occured,received data is null.")
                    return
                }
                // 输出结果
                print(String(data: characteristic.value!, encoding: .utf8) ?? " nothing ")
                // 使用变量记录传输过来的 data
                let replyDateStr = String(data: characteristic.value!, encoding: .utf8)!
                
                // 如果发过来的是 meter ID，判断是否之前这个仪器传输过数据。
                // 如果有传输过, 则将与该仪器相关的最新数据的 日期 血糖值 标记位 依次发过去
                // 如果没有传输过， 则告诉该仪器将数据传输过来
                // 通过 command type来判断对数据的操作和将要传输的命令
                switch replyDateStr[1]{
                case "M":
                    // 如果收到meterID，说明对应上了设备类型
                    if replyDateStr != "&M0 41870"{
                        // 设置meterID值
                        self.meterID = replyDateStr
                        print("当前设备的meterID为：\(replyDateStr)")
                        print("收到meterID,查看是否之前与之通信过")
//                        self.logUpload("当前设备的meterID为：\(replyDateStr),收到meterID,查看是否之前与之通信过")
                        
                        // 由于本次测试的仪器的 2个特征值都相同，所以要向有 write 属性的特征值发送数据
                        // 如果存储 meterID 的数组包含 蓝牙发送过来的meterID
                        if self.meterIDs![replyDateStr] != nil{
                            // 改变显示在屏幕的提示标签文本
                            self.loadV.setLabelText("Data is in History Transmission Records")
                            print("通信过，发送App记录的最晚通讯记录，包括时间、血糖值、标记位")
//                            self.logUpload("通信过，发送App记录的最晚通讯记录，包括时间、血糖值、标记位")
                            // 获取上一次传输的最新记录
                            let str = self.meterIDs![replyDateStr] as! String
                            // 按空格分开
                            let array:Array<String> = str.components(separatedBy: " ")
                            // 抽出时间，并将其转为d一定格式的字符串
                            let date = "&D" + array[0][2,11] + " "
                            let SendData = date + crc.string2CRC(string: date)
                            print("CRC验证码为：\(SendData)")
                            // 发送时间
                            peripheral.writeValue(SendData.data(using: .utf8)!, for: self.writeCharacteristic ?? characteristic, type: .withoutResponse)
//                            self.logUpload("发送CRC验证码：\(SendData)")
                        }
                            // 如果之前未与该蓝牙通信过，则让其发送所有蓝牙数据
                        else{
                            // 改变显示在屏幕的提示标签文本
                            self.loadV.setLabelText("No History Transmission Record.Accept All Data from Meter")
//                            self.logUpload("No History Transmission Record.Accept All Data from Meter")
                            peripheral.writeValue("&N1 13183".data(using: .utf8)!, for: self.writeCharacteristic ?? characteristic, type: .withoutResponse)
                            //self.meterIDs![replyDateStr] = ""
                        }
                    }
                    else{
                        // 尝试其他的 meter类型
                        // 如果 meterType>=0，向ble发命令
                        if self.meterType>=0{
                            // 首先确定命令字符串
                            
                            let meterStr = "&T"+String(self.meterType,radix: 16).uppercased()+" "
                            let order = meterStr + crc.string2CRC(string: meterStr)
                            print("所发字符"+meterStr)
                            print("所发的顺序"+order)
//                            self.logUpload("尝试其他的 meter类型,发送命令\(order)")
                            // 将字符串转为Data，发送蓝牙命令必须为Data型
                            let byteDate0 = order.data(using: .utf8)
                            peripheral.writeValue(byteDate0!, for: self.writeCharacteristic ?? characteristic, type: .withoutResponse)
                            self.meterType -= 1
                        }
                        else{
                            
                            print("无法识别的仪器类型")
//                            self.logUpload("无法识别的仪器类型")
                            wrongInfo = "Unrecognizable Meter Type"
                            
                        }
                    }
                case "D":
                    print("收到对时间的回复")
//                    self.logUpload("收到对时间的回复")
                    // 收到对时间的确认，发送血糖值
                    if replyDateStr == "&D1 12639"{
                        print("发送血糖值")
//                        self.logUpload("发送血糖值")
                        // 获取上一次传输的最新记录
                        let str = self.meterIDs![self.meterID] as! String
                        // 按空格分开
                        let array:Array<String> = str.components(separatedBy: " ")
                        // 抽出血糖值，并将其转为一定格式的字符串
                        let date = "&R" + array[1] + " "
                        //                        let date = "&R158 "
                        // 字符串 + CRC
                        let SendData = date + crc.string2CRC(string: date)
//                        self.logUpload("CRC验证码为：\(SendData)")
                        peripheral.writeValue(SendData.data(using: .utf8)!, for: self.writeCharacteristic ?? characteristic, type: .withoutResponse)
//                        self.logUpload("发送CRC验证码：\(SendData)")
                    }else{
                        wrongInfo = "Incorrect Receiving of Blood Glucose Meter Information"
                    }
                case "R":
//                    self.logUpload("收到对血糖值的回复")
                    // 收到对血糖值的确认，发送标志位
                    if replyDateStr == "&R1 62910"{
//                        self.logUpload("发送标志位")
                        // 获取上一次传输的最新记录
                        let str = self.meterIDs![self.meterID] as! String
                        // 按空格分开
                        let array:Array<String> = str.components(separatedBy: " ")
                        // 抽出标志位，并将其转为一定格式的字符串
                        let date = "&K" + array[2] + " "
                        //                        let date = "&K0 "
//                        self.logUpload(array[2])
                        // 字符串 + CRC
                        let SendData = date + crc.string2CRC(string: date)
//                        self.logUpload("CRC验证码为：\(SendData)")
                        peripheral.writeValue(SendData.data(using: .utf8)!, for: self.writeCharacteristic ?? characteristic, type: .withoutResponse)
//                        self.logUpload("发送CRC验证码：\(SendData)")
                    }else{
                        wrongInfo = "Incorrect Receiving of Blood Glucose Meter Information"
                    }
                case "K":
//                    self.logUpload("收到对标志位的回复")
                    // 收到对标志位的确认，告诉仪器发送数据
                    if replyDateStr == "&K1 12911"{
//                        self.logUpload("告诉仪器发送数据")
                        let SendData = "&N0 " + crc.string2CRC(string: "&N0 ")
//                        self.logUpload("CRC验证码为：\(SendData)")
                        if let xdata=SendData.data(using: .utf8){
                            peripheral.writeValue(xdata, for: self.writeCharacteristic ?? characteristic, type: .withoutResponse)
//                            self.logUpload("发送CRC验证码：\(SendData)")
                        }else{
//                            self.logUpload("\(SendData)转utf8失败")
                        }
                        
                        
                    }else{
                        wrongInfo = "Incorrect Receiving of Blood Glucose Meter Information"
                    }
                    
                // 如果有数据要发过来
                case "N":
                    let array1:Array<String> = replyDateStr.components(separatedBy: " ")
                    // 如果数据，说明是数据。将数据解析出来并存入相应数组中
                    // 数据本身也要存入数组方便之后的CRC验证
                    if array1.count>2{
//                        self.logUpload("收到血糖数据")
                        if self.isFirstRecord{
                            
                            self.lastRecord = replyDateStr
                            self.isFirstRecord = false
                        }
                        
                        self.dataOrder += 1
                        // 改变显示在屏幕的提示标签文本
                        self.loadV.setLabelText("Receiving  Data \(self.dataOrder)\\\(self.dataCount)")
                        // 将数据分析出来并将数据结果放到对应的数组中存储起来
                        self.glucoseDataAnalysis(replyDateStr)
                        // data 不能直接转 [Int],选择先转 [UInt8]
                        let x = [UInt8](characteristic.value!)
                        // 这里 dataSting 使用 [Int] 保证数据的完整
                        // 是因为如果为字符串形式，会忽略掉一些 ASCII中存在的不显示的字符。
                        // 实际上传输的数据每两个数据之间会有一个 记录分隔符，十进制为10
                        for i in x{
                            self.dataSting.append(Int(i))
                        }
                        //self.viewController.tableView.reloadData()
                        
                    }
                        // 如果数据根据空格分割后小于3个，说明:
                        //  1、其是CRC验证码，验证它
                        //  2、蓝牙返回其 将要传输多少条数据
                    else{
                        
                        
                        // 若不包含空格，肯定是CRC验证码
                        if !replyDateStr.contains(" "){
                            
                            // 主动断开连接
                            self.centralManager?.cancelPeripheralConnection(peripheral)
                            // 加入 ”&N“，为验证crc
                            let str2check:String = "&N"
                            for scalar in str2check.unicodeScalars{
                                self.dataSting.append(Int(scalar.value))
                            }
                            /*
                             replyDateStr为 "&N 7072",但实际末尾有一个看不见的字符
                             所以要将 我们计算得到的CRC变成字符串 与 replyDateStr字符串的 3...replyDateStr.count-2 比较
                             */
                            
                            if String(crc.getCRC(arr: self.dataSting)) != replyDateStr[3,replyDateStr.count-2]{
//                                self.logUpload("CRC:\(String(replyDateStr[2,replyDateStr.count-1]))验证错误，数据可能来源非法。")
                                wrongInfo = "CRC ERROR"
                            }
                            else{
                                
//                                self.logUpload("CRC:\(String(replyDateStr[2,replyDateStr.count-1])) 验证正确。跳转页面显示血糖数据")
                                print("CRC:\(String(replyDateStr[2,replyDateStr.count-1])) 验证正确。跳转页面显示血糖数据")
                                
                                // 将加载视图移除界面，并使其图片动画停止
                                self.loadV.stopIndicator()
                                
                                //如果lastRecord不为”“，说明有数据，跳转
                                if(self.lastRecord != ""){
                                    // 转到展示数据的页面
                                    let gluVC = gluViewController()
                                    var glucoseMark:[Int] = []
                                    var glucoseDate:[String] = []
                                    var glucoseValue:[Int] = []
                                    var glucoseUUID:[String] = []
                                    if self.BLEglucoseMark.count>0{
                                        for i in 0..<self.BLEglucoseMark.count{
                                            if self.BLEglucoseMark[i] == 0 || self.BLEglucoseMark[i] == 1 || self.BLEglucoseMark[i] == 2 || self.BLEglucoseMark[i] == 4{
                                                // set uuid list
                                                // 创建一个recordId
                                                let uuid = UUID().uuidString.components(separatedBy: "-").joined()
                                                glucoseUUID.append(uuid)
                                                
                                                glucoseMark.append(self.BLEglucoseMark[i])
                                                glucoseDate.append(self.BLEglucoseDate[i])
                                                glucoseValue.append(self.BLEglucoseValue[i])
                                            }
                                        }
                                    }
                                    
                                    // 初始化数据，并刷新表格
                                    gluVC.uuidList = glucoseUUID
                                    gluVC.BLEglucoseDate = glucoseDate
                                    gluVC.BLEglucoseMark = glucoseMark
                                    gluVC.BLEglucoseValue = glucoseValue
                                    // 要去掉最后一个字符
                                    let strRange = self.lastRecord.count - 2
                                    gluVC.lastRecord = self.lastRecord[0,strRange]
                                    gluVC.meterID = self.meterID
                                    gluVC.tableView.reloadData()
                                    self.initAllDate()
                                    self.navigationController?.pushViewController(gluVC, animated: true)
                                    
                                }else{ // 没有数据，提示
                                    // 将加载视图移除界面，并使其图片动画停止
                                    self.loadV.stopIndicator()
                                    wrongInfo = "No new data"
//                                    self.logUpload("No New Data In Machine")
                                }
                            }
                        }
                        else{
                            
                            // 如果传过来的是对”No Data“的yes确认回复，说明没有数据要传输
                            if replyDateStr[2] == "y"{
                                // 改变显示在屏幕的提示标签文本
                                self.loadV.setLabelText("No Data in the Meter")
                                // 将加载视图移除界面，并使其图片动画停止
                                self.loadV.stopIndicator()
                                wrongInfo = "No Data in the Meter"
//                                self.logUpload("No Data Need To Send.")
                            }else{
                                print("将要传输的数据数量量")
                                // 包含空格，那么该数据包含将要发送过来的数据数量
                                // 形式类似于 &N10 63614
                                let array:Array<String> = replyDateStr.components(separatedBy: " ")
//                                self.logUpload("将要传输\(array[0][2,array[0].count-1])个数据。")
                                if array[0][2,array[0].count-1] == "0"{
                                    wrongInfo = "No new data"
//                                    self.logUpload("No New Data In Machine")
                                }
                                self.dataCount = Int(array[0][2,array[0].count-1])!
                            }
                            
                            
                        }
                    }
                default:
//                    self.logUpload("unknown")
                    wrongInfo = "unknown error occured."
                    
                }
                // 若传输数据过程中有任何异常或无数据传输，执行
                if let x = wrongInfo{
                    
                    // 主动断开连接
                    self.centralManager?.cancelPeripheralConnection(peripheral)
                    // 将加载视图移除界面，并使其图片动画停止
                    //                    self.loadV.removeFromSuperview()
                    self.loadV.stopIndicator()
                    self.initAllDate()
                    // 弹出警示框，说明相关错误信息
                    let alert = CustomAlertController()
                    alert.custom(self, "", x)
                }
            }
        }
    }
    
    // 发送命令的回调
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if (error != nil)  {
//            self.logUpload("发生错误:\(String(describing: error))")
        }
        else{
//            self.logUpload("发送命令成功。")
        }
    }
    
    // 存储App连接过的血糖仪ID
    var meterIDs:NSMutableDictionary?
    // 点击该按钮扫描设备
    private var button:UIButton = {
        let button = UIButton(type: .system)
        //button.tintColor = UIColor.white
        //        button.backgroundColor = SendButtonColor
        // button.titleLabel?.text = "扫描设备"
        button.setTitleColor(UIColor.white, for: .normal)
        //        button.setSelected()
        button.backgroundColor = UIColor.clear
        button.layer.borderColor = ThemeColor.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Scan", for: .normal)
        button.addTarget(self, action: #selector(scanDev), for: .touchUpInside)
        return button
    }()
    
    @objc func scanDev(){
        peripherals = []
        deviceDic = []
        deviceName = []
//        self.logUpload("点击 扫描设备 按钮")
        self.centralManager?.scanForPeripherals(withServices: [glucoseDevServiceCBUUID])
        tableView.reloadData()
        // 对c扫描时间进行计时
        startScanTimer()
    }
    
    // 加载视图
    private lazy var loadV:CustomIndicatorView = {
        let view = CustomIndicatorView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: AJScreenHeight))
        view.setupUI("")
        //view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        return view
    }()
    
    // 设置导航栏左按钮样式
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "back"), for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
    // 点击左按钮的动作
    @objc func leftButtonClick(){
        stopScanTimer()
        // 设置返回首页
        //        self.tabBarController?.selectedIndex = 0
        //        self.tabBarController?.tabBar.isHidden = false
        
        // back to last view
        self.navigationController?.popViewController(animated: false)
    }
    
    //     设置导航栏右按钮样式
    private lazy var rightButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "edit"), for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
        return button
    }()
    //     点击右按钮的动作
    @objc func rightButtonClick(){
        stopScanTimer()
        // 设置去手动输入界面
        let insert = InsertViewController()
        insert.title = "Add"
        self.navigationController?.pushViewController(insert, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        self.automaticallyAdjustsScrollViewInsets = false
        // 隐藏tabbar
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        // 初始化数据
        initAllDate()
        // 重新加载表格视图
        self.tableView.reloadData()
    }
    
    // 页面消失，tabbar隐藏
    override func viewWillDisappear(_ animated: Bool) {
        //        self.tabBarController?.tabBar.isHidden = false
        self.button.setTitle("Scan", for: .normal)
        //        stopScanTimer()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.title = "Bluetooth"
        // 添加导航栏左按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        // 添加导航栏右按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        // Do any additional setup after loading the view.
        
        // 添加底部图片
        //        button.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY-40, width: UIScreen.main.bounds.width, height: 44)
        self.view.addSubview(button)
        button.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }
            make.height.equalTo(44)
        }
        // 设置表格布局，设置其代理和数据来源，将其加入视图
        // tableView设置
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.clipsToBounds = true
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            //            make.top.equalTo(tableHeadLabel.snp.bottom)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                //                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
                //                make.bottom.equalTo(bottomLayoutGuide.snp.top)
                // Fallback on earlier versions
            }
            make.bottom.equalTo(button.snp.top)
        }
        
        // 设置中心设备代理
        centralManager = CBCentralManager.init(delegate: self, queue: nil)
        
        // 首先确定命令字符串
        let crc = CRC16()
        let meterStr = "&T"+String(meterType,radix:16).uppercased()+" "
        let order = meterStr + crc.string2CRC(string: meterStr)
//        logUpload("/***************蓝牙界面开始*****************/")
//        self.logUpload("初始命令"+order)
        
        // 将字符串转为Data，发送蓝牙命令必须为Data型
        byteDate = order.data(using: .utf8)
        
        // 读取配置文件，获取meterID的内容
        let path = PlistSetting.getFilePath(File: "otherSettings.plist")
        let data1:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        
        // 设置为字典型
        meterIDs = data1["meterID"] as? NSMutableDictionary
//        self.logUpload("存储的meterID有:\(String(describing: meterIDs))")
        print("存储的meterID有:\(String(describing: meterIDs))")
        
        // 设置监听器，监听是否弹出插入成功r弹窗
        NotificationCenter.default.addObserver(self, selector: #selector(InsertSuccess), name: NSNotification.Name(rawValue: "InsertData"), object: nil)
        
    }
    
    @objc func InsertSuccess(){
        // 跳转到home界面
        self.tabBarController?.selectedIndex = 0
        
    }
    
    
    // 对于传输过来的血糖数据的处理
    func glucoseDataAnalysis(_ string:String){
        // 按空格分开
        let array:Array<String> = string.components(separatedBy: " ")
        // 将字符串拆成 每个字符串只包含一个字符 的 字符串数组
        //let data = array[0].components(separatedBy: "")
//        self.logUpload("处理后的数据\(array)")
        let data = array[0]
        // 将其组合为时间，格式为 20xx-xx-xx xx:xx 年-月-日 小时:分钟
        //let date = "20"+data[6]+data[7]+"-"+data[2]+data[3]+"-"+data[4]+data[5]+" "+data[8]+data[9]+":"+data[10]+data[11]
        let date = "20" + data[6,7]+"-"+data[2,3]+"-"+data[4,5]+" "+data[8,9]+":"+data[10,11]
        // 读取血糖值
        let glucoseReading = Int(array[1])
        // 读取标志位
        let CT = array[2].count-2
        let mark0 = array[2]
        let glucoseMark = Int(mark0[0,CT])
        // 将日期字符串存入数组
        BLEglucoseDate.append(date)
        // 将血糖值存入数组
        BLEglucoseValue.append(glucoseReading ?? 0)
        // 将血糖值存入数组
        BLEglucoseMark.append(glucoseMark!)
        //self.viewController.tableView.reloadData()
        
    }
    // MARK:- 初始化所有全局变量
    func initAllDate(){
        
        // 初始化数据
        meterType = 14
        // 最新血糖记录
        lastRecord = ""
        // 所要返回的数据量
        dataCount = 0
        // 第几个数据
        dataOrder = 0
        
        // 记录有 .read 和 .notify 的 特征值
        readCharacteristic = nil
        // 记录有 .write 特征值
        writeCharacteristic = nil
        // 是否为第一个血糖数据
        isFirstRecord = true
        
        
        // 以int型存储要传过来的血糖数据以便使用CRC验证码验证
        dataSting = []
        
        // 存储读取的数据中的血糖记录的时间
        BLEglucoseDate = []
        // 存取读取的数据中的血糖值
        BLEglucoseValue = []
        // 存储读取的数据中的血糖标志位
        BLEglucoseMark = []
        
        // 首先确定命令字符串
        let crc = CRC16()
        let meterStr = "&T"+String(self.meterType,radix: 16).uppercased()+" "
        let order = meterStr + crc.string2CRC(string: meterStr)
        
        // 将字符串转为Data，发送蓝牙命令必须为Data型
        byteDate = order.data(using: .utf8)
        
        // 读取配置文件，获取meterID的内容
        let path = PlistSetting.getFilePath(File: "otherSettings.plist")
        let data1:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        
        // 设置为字典型
        meterIDs = data1["meterID"] as? NSMutableDictionary
//        self.logUpload("存储的meterID有:\(String(describing: meterIDs))")
    }
    
    
}

extension BLEViewController{
    
//    // 上传日志
//    func logUpload(_ info:String) {
//        let dictString = [ "bugInfo": info]
//        let logURL = "https://bgapp.acondiabetescare.com/app/bugUpload"
//        // 向服务器申请插入数据请求
//        AlamofireManagerForBLE.request(logURL,method: .post,parameters: dictString, headers:vheader).responseString{ (response) in
//            if response.result.isSuccess{
//
//            }
//        }//end of request
//    }
//
    // MARK: - 为连接设备进行计时
    // 1.开始计时
    func startTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updataSecond), userInfo: nil, repeats: true)
        //调用fire()会立即启动计时器
        timer!.fire()
    }
    
    // 2.定时操作
    @objc func updataSecond() {
        if second>1 {
            //.........
            second -= 1
        }else {
            stopTimer()
        }
    }
    
    // 3.停止计时
    func stopTimer() {
        if timer != nil {
            timer!.invalidate() //销毁timer
            timer = nil
            loadV.stopIndicator()
            let x = UIAlertController(title: "", message: "Connecting Failed", preferredStyle: .alert)
            self.present(x, animated: true, completion: {()->Void in
                sleep(1)
                x.dismiss(animated: true, completion: {
                })
            })
            
        }
        // 不要忘了设置second以便下次使用
        second = 10
    }
    
    // MARK: - 为扫描设备进行计时
    // 1.开始计时
    func startScanTimer() {
        
        timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updataScanSecond), userInfo: nil, repeats: true)
        //调用fire()会立即启动计时器
        timer1!.fire()
        //        self.button.setDeselected()
        self.button.isEnabled = false
        self.button.setTitle("Scanning...", for: .normal)
    }
    
    // 2.定时操作
    @objc func updataScanSecond() {
        if second1>1 {
            //.........
            second1 -= 1
        }else {
            stopScanTimer()
        }
    }
    
    // 3.停止计时
    func stopScanTimer() {
        if timer1 != nil {
            timer1!.invalidate() //销毁timer
            timer1 = nil
            self.centralManager?.stopScan()
            //            self.loadV.stopIndicator()
            //            self.loadV.removeFromSuperview()
            //            self.button.setSelected()
            self.button.isEnabled = true
            self.button.setTitle("Scan", for: .normal)
            // 不要忘了设置second以便下次使用
            second1 = 10
//            self.logUpload("stop scan")
        }
    }
}

