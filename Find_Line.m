clear; clc; close all;
f = mat2gray(rgb2gray(imread('IMG_0170.jpg')));
I = imcrop(f,[1200 1200 2200 1200]);
E = size(I);
K = I;
for i = 1:E(1)                  
    for j = 1:E(2)              
        if I(i, j) >= 0.70      
            K(i, j) = 1;        
        else                    
            K(i, j) = 0;        
        end
    end
end

BW = edge(K,'canny', 0.1, 1);
[H,T,R] = hough(BW);
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

P  = houghpeaks(H, 8,'threshold', 100, 'NHoodSize', [301 3]);
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');

lines = houghlines(BW,T,R,P,'FillGap',80,'MinLength', 400);
figure, imshow(I), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','blue');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','yellow');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end