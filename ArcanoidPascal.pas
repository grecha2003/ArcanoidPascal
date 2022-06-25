program ArkanoidPascal;

Uses GraphABC, ABCObjects;

var
  blocks: array[1..50] of PictureABC;
  i, j, playerX, playerY, ballX, ballY, kx, ky: integer;
  keyLeft, keyRight: boolean;
  player: PictureABC;
  ball: PictureABC;

procedure keyDown(key: integer);
begin
  if (key = vk_left) then
    keyLeft := true;
  if (key = vk_right) then 
    keyRight := true;
end;

procedure keyUp(key: integer);
begin
  if (key = vk_left) then
    keyLeft := false;
  if (key = vk_right) then
    keyRight := false;
end;

begin
  
  window.Init(100, 100, 649, 480, clBrown); 
  setwindowsize(649, 480);
  
  for i := 1 to 5 do 
  begin
    for j := 1 to 10 do
    begin
      blocks[(i - 1) * 10 + j] := PictureABC.Create(65 * (j - 1), 35 * (i - 1), './assets/block.png');
    end;
  end;
  
  onKeyDown := keyDown;
  onKeyUp := keyUp;
  playerX := 100;
  playerY := windowHeight - 30;
  ballX := 100;
  ballY := 300;
  
  player := PictureABC.Create(playerX, playerY, './assets/platform.png');
  ball := PictureABC.Create(ballX, ballY, './assets/ball.png');
  ball.ScaleX := 1.50;
  ball.ScaleY := 1.50;
  
  kx := 1;
  ky := 1;
  
  while(true) do
  begin
    player.MoveTo(playerX, playerY);
    if (keyLeft = true) then
      playerX := playerX - 1;
    if (keyRight = true) then 
      playerX := playerX + 1;
    
    if (playerX > windowWidth - player.Width) then
      playerX := windowWidth - player.Width;
    if (playerX < 0) then
      playerX := 0;
    
    ballX := ballX + kx;
    ballY := ballY + ky;
    
    if ((ballX < 0) or (ballX > windowWidth - ball.Width)) then
      kx := -kx;
    if (ballY < 0) then
      ky := -ky;
    
    ball.MoveTo(ballX, ballY);
    
    for i := 1 to 50 do
    begin
      if (ball.Intersect(blocks[i]) = true) then
      begin
        blocks[i].Visible := false;
        blocks[i].MoveTo(700, 700);
        ky := -ky;
      end;
    end;
    if (ball.Intersect(player)) then
    begin
      ballY := ballY - 10;
      ky := -ky;
    end;
    if (ballY > windowHeight) then
    begin
      ballX := windowWidth div 2;
      ballY := windowHeight div 2;
    end;
    
  end;

end.