unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, StdCtrls, Buttons, ComCtrls, ToolWin;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Rock1: TImage;
    Ball: TShape;
    time: TTimer;
    Rock2: TImage;
    Time2: TTimer;
    Timer1: TLabel;
    time3: TTimer;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure timeTimer(Sender: TObject);
    procedure Time2Timer(Sender: TObject);
    procedure time3Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  pop,timer:Integer; //������� �����
  dx, dy,rs1,rs2 : Integer; //dx � dy - �������� ������, rs1-�������� �������


implementation

uses Unit2, Unit4;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  time.Enabled:=false;
  time2.Enabled:=false;
  Button1.Enabled:=true;
  rs1:=10;
  rs2:=11;
  pop:=1;
  dx := 2;  // ��������� �������� �� ��� OX
  dy := 2;  // ��������� �������� �� ��� OY
  form1.DoubleBuffered:=Enabled;   //������� �����������
  form1.KeyPreview := true;     //���������� ���������� ������ ��� �������� ����������
  end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;  //����������� ������ ��� ���������� ��������
  Shift: TShiftState);
  begin
    Case key of            //��� ������� ������ "NUM_PAD_8" ������� ����� ��������� ����� �� �������� 10 �/c
    VK_NUMPAD8:
      begin
       if (Rock1.Top >= 75) then
        Rock1.Top := Rock1.Top - rs1;
        Exit;
      end;
    VK_NUMPAD5:           //��� ������� ������ "NUM_PAD_5" ������� ����� ��������� ���� �� �������� 10 �/c
      begin
       if (Rock1.Top <= 303) then
        Rock1.Top := Rock1.Top  + rs1;
        Exit;
      end;
    end;
end;
procedure TForm1.timeTimer(Sender: TObject); //�������� ���� � ������� ����������� �������� ���������
var
  s:string;
  i,button2:Integer;
  b:Boolean;
  button:string;
  F : TextFile;
begin
  b:=False;            // ���������� b ����� �������� �� ����������� � ���������� ������ "Time"
    Ball.left := Ball.Left + dx;
    Ball.Top := Ball.Top + dy;
      Button1.Enabled:=false;
      if Ball.Top <=Image1.Top + 50  then         //��������� ������� ���� �� ������
        dy :=dy*-1;
      if Ball.Top >=Image1.Top + 334 then
        dy :=dy*-1;
         //��������� ������� ���� �� �������
      if ((Ball.left = (Rock2.left - 12)) and ((Ball.top >(Rock2.top-12))) and (Ball.top <(Rock2.top + Rock2.Height+2))) then //������� ��� 2 ������� (������ �������)
        dx:= dx * -1; //��� ���������� ����� ���������� ������ ������� ������� - ��� ������ ����������� �� ��� OX �� ���������������
      if ((Ball.left = (Rock1.left + 11)) and ((Ball.top >(Rock1.top-12))) and (Ball.top <(Rock1.top + Rock1.Height+2))) then  //������� ��� 1 ������� (����� �������)
        dx:= dx * -1;
      if (Ball.left <= Rock1.left + 10) and ((Ball.Top = (Rock1.Top + Rock1.Height)) or (Ball.Top = (Rock1.Top-11))) then //������� ��� 1 ������� (����� �������)
        dy:= dy * -1;//��� ���������� ����� ���������� ������ ������� ������� - ��� ������ ����������� �� ��� OX �� ���������������
      if (Ball.left >= Rock2.left - 12) and ((Ball.Top = (Rock2.Top + Rock2.Height)) or (Ball.Top = (Rock2.Top-11))) then //������� ��� 2 ������� (������ �������)
          dy:= dy * -1;
       //����� �������� �������
          If (Ball.left >= Image1.Left + 580) and (Ball.left <= Image1.Left + 605)  then  //��������� ���� � ���� ��������� 2 ������
        begin
          time.Enabled:=b;      //��� ��������� ���� � ���� ��������� ������ "Time1" � "Time2" ����������� �������� "False", ��� ����� ���� ���������������
          time2.Enabled:=b;
        end;
          If (Ball.left <= Image1.Left + 5) and (Ball.left <= Image1.Left - 10) then //��������� ���� � ���� ��������� 2 ������
        begin
          time.Enabled:=b;
          time2.Enabled:=b;
          Button1.Enabled:=true;
          dec(Pop);
        end;
         s:=form4.StringGrid1.Cells[2,6];
         if pop=0 then
       if timer>StrToInt(Form4.StringGrid1.Cells[2,6]) then
          begin
            button := InputBox('���� ��������', '��� ������: '+inttostr(timer), '������� ���� ���');
             while length(button) > 10 do
             begin
              button := InputBox('������', '����� ����� �� ����� ��������� 9 ��������', '������� ���� ���');
             while button = '' do
              button := InputBox('������', '� ���� ����� �� ���� ������� ���', '������� ���� ���');
             end;
                Form4.stringgrid1.cells[1,6]:='';
                Form4.stringgrid1.cells[2,6]:='';
                Form4.stringgrid1.cells[1,6]:=button;
                Form4.stringgrid1.cells[2,6]:=inttostr(timer);
                AssignFile(F, 'Scores.txt');
                Rewrite(F);
                For I := 0 to Form4.StringGrid1.RowCount - 1 do
                Writeln(F,Form4.StringGrid1.Cells[1,I] +','+Form4.StringGrid1.Cells[2,I]);
                CloseFile(F);
            If button <> '' then Form1.Close;
            if not (Assigned(Form4)) then
              Form4:=TForm4.Create(self);
                Form4.Show;
          end
       else
        begin
         button2:=MessageDlg('���� ��������',mtCustom,[mbRetry,mbCancel], 0);
          if button2 = mrCancel then Form1.Close;
          if button2 = mrRetry then Button1.Click;
        end;
  end;

procedure TForm1.Button1Click(Sender: TObject);     //������ Start
begin
  if getasynckeystate(VK_SPACE)<>0 then
    Button1.click;
      Ball.top:=216;
        Ball.Left:=314;
          time.Enabled:=true;
            time2.Enabled:=true;
              Timer:=0;
                time.Interval:=18;
                  rs1:=10;
                    rs2:=11;
                      pop:=1;
end;

procedure TForm1.Time2Timer(Sender: TObject);    //����������� �������
begin
Inc(timer);
timer1.Caption:=FloatToStr(timer);
  if (timer = 5) then time.Interval:=15;
  if (timer = 10) then timer1.left:=311;
  if (timer = 15) then time.Interval:=1;
  if (timer = 30) then   rs1:=5;
  if (timer = 45) then   rs1:=3;
  if (timer = 55) then   rs1:=2;
  if (timer = 75) then   rs1:=1;
end;


procedure TForm1.time3Timer(Sender: TObject);
  begin
   if (Rock2.Top> ClientHeight - Rock2.Height - 40) then
    Rock2.Top:=Rock2.Top
   else
    if Ball.Top>Rock2.Top then
      Rock2.Top:=(Ball.Top+Rock2.Width);
    if Ball.Top<Rock2.Top then
      Rock2.Top:=(Ball.Top - Rock2.Width+rs2);
  end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Rock1.Top:=194;
  rs1:=10;
  rs2:=11;
  pop:=1;
  Ball.top:=216;
  Ball.Left:=314;
  Timer:=0;
  Timer1.Caption:='0';
  time.Interval:=18;
  rs1:=10;
  rs2:=11;
  dx := 2;
  dy := 2;
  Button1.Enabled:=true;
  time.Enabled:=false;
  time2.Enabled:=false;
  form2.Visible:=true;
  Form2.show;
end;

end.
