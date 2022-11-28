object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 328
  Width = 354
  object conn: TFDConnection
    Params.Strings = (
      
        'Database=D:\Users\aluno\Downloads\MyTime- Sharline-Diego Roeder-' +
        ' Ryan (1)\MyTime- Sharline-Diego Roeder- Ryan (2)\MyTime- Sharli' +
        'ne-Diego Roeder- Ryan\DB\banco.db'
      'OpenMode=ReadWrite'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    AfterConnect = connAfterConnect
    BeforeConnect = connBeforeConnect
    Left = 56
    Top = 32
  end
end
