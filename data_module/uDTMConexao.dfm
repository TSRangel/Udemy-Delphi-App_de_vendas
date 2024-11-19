object dtmPrincipal: TdtmPrincipal
  Height = 480
  Width = 640
  object ConexaoDB: TFDConnection
    Params.Strings = (
      'Database=delphi'
      'User_Name=root'
      'Password=!@#1q2w3e4r'
      'Server=localhost'
      'DriverID=MySQL')
    TxOptions.Isolation = xiReadCommitted
    TxOptions.AutoStop = False
    Connected = True
    LoginPrompt = False
    Left = 288
    Top = 200
  end
end
