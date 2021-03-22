incRate = 0.01;

if(keyboard_check(vk_left))
	fgmult -= incRate;
else if(keyboard_check(vk_right))
	fgmult += incRate;
	
if(keyboard_check(vk_down))
	alpha -= incRate;
else if(keyboard_check(vk_up))
	alpha += incRate;
	
if(keyboard_check(ord("Q")))
	colR += 1;
else if(keyboard_check(ord("A")))
	colR -= 1;
	
if(keyboard_check(ord("W")))
	colG += 1;
else if(keyboard_check(ord("S")))
	colG -= 1;
	
if(keyboard_check(ord("E")))
	colB += 1;
else if(keyboard_check(ord("D")))
	colB -= 1;
	
fgmult = clamp(fgmult, 0, 1);
color = make_color_rgb(colR, colG, colB);

x = mouse_x;
y = mouse_y;
light[lightSys.lx] = x;
light[lightSys.ly] = y;
light[lightSys.FGmult] = fgmult;
light[lightSys.col] = color;
light[lightSys.alpha] = alpha
light_enqueue(light);