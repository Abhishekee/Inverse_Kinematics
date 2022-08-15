%% Two Link Inverse Kinematics

l1 = 10; %length of first arm
l2 = 7; %length of second arm

theta1 = 0:0.1:pi/2; %all possible theta1 values
theta2 = 0:0.1:pi; %all possible theta2 values

[THETA1,THET2] = meshgrid(theta1,theta2); %generate grid of angle values
X = l1 * cos(THETA1) + l2 * cos(THETA1 + THETA2); %compute x coordinates
Y = l1 * sin(THETA1) + L2 * sin(THETA1 + THETA2); %compute y coordinate

data1 = [X(:) Y(:) THETA1(:)]; %Create x-y-theta1 dataset
data2 = [X(:) Y(:) THETA2(:)]; %CREATE X-Y-THETA2 DATASET

plot(X(:),Y(:),'g');
axis equal;
xlabel('X','fontsize',10)
ylabel('Y','fontsize',10)
title('X-Y coordinates for all combinations','fontsize',10)