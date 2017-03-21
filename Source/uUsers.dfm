object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Connected Users'
  ClientHeight = 460
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 19
  object lst1: TListBox
    Left = 0
    Top = 33
    Width = 288
    Height = 427
    Align = alClient
    ItemHeight = 19
    TabOrder = 0
    ExplicitTop = 57
    ExplicitWidth = 313
    ExplicitHeight = 403
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 288
    Height = 33
    Align = alTop
    TabOrder = 1
    object lbl1: TLabel
      Left = 1
      Top = 1
      Width = 286
      Height = 31
      Align = alClient
      Alignment = taCenter
      Caption = 'IP:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 104
      ExplicitTop = 26
      ExplicitWidth = 27
      ExplicitHeight = 25
    end
  end
end
