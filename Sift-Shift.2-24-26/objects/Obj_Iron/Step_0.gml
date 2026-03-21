x += vx;
y += vy;

vx *= fric;
vy *= fric;

vx = clamp(vx, -max_speed, max_speed);
vy = clamp(vy, -max_speed, max_speed);