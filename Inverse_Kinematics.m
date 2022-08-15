%% Two Link Inverse Kinematics

l1 = 15; %length of first arm
l2 = 11; %length of second arm

theta1 = 0:0.01:pi/2; %all possible theta1 values
theta2 = 0:0.01:pi; %all possible theta2 values

[THETA1,THETA2] = meshgrid(theta1,theta2); %generate grid of angle values
X = l1 * cos(THETA1) + l2 * cos(THETA1 + THETA2); %compute x coordinates
Y = l1 * sin(THETA1) + l2 * sin(THETA1 + THETA2); %compute y coordinate

data1 = [X(:) Y(:) THETA1(:)]; %Create x-y-theta1 dataset
data2 = [X(:) Y(:) THETA2(:)]; %CREATE X-Y-THETA2 DATASET

figure(1)
plot(X(:),Y(:),'gs');
axis equal;
xlabel('X','fontsize',10)
ylabel('Y','fontsize',10)
title('X-Y coordinates for all combinations','fontsize',10)

%% ANFIS 

opt = anfisOptions;
opt.InitialFIS = 7;
opt.EpochNumber = 150;
opt.DisplayANFISInformation = 0;
opt.DisplayErrorValues = 0;
opt.DisplayStepSize = 0;
opt.DisplayFinalResults = 0;

disp('--> Training first ANFIS network')
anfis1 = anfis(data1,opt);
disp('--> Training second ANFIS network')
opt.InitialFIS = 6;
anfis2 = anfis(data2,opt);
x = 0:0.1:2; %x-cord for validation
y = 8:0.1:10; %y-cord for validation

[X,Y] = meshgrid(x,y);
c2 = (X.^2 + Y.^2 - l1^2 - l2^2)/(2*l1*l2);
s2 = sqrt(1-c2.^2);
THETA2D = atan2(s2,c2); %theta2 is deduced
k1 = l1 + l2.*c2;
k2 = l2*s2;
THETA1D = atan2(Y,X)- atan2(k2,k1); %theta1 is deduced

XY = [X(:) Y(:)];
THETA1P = evalfis(anfis1,XY);
THETA2P = evalfis(anfis2,XY);

theta1diff = THETA1D(:) - THETA1P;
theta2diff = THETA2D(:) - THETA2P;

figure(2)
subplot(2,1,1)
plot(theta1diff,'y','linewidth',3)
ylabel('THETA1D - THETA1P')
title('Deduced theta1 - Predicted theta1')

subplot(2,1,2)
plot(theta2diff,'g','linewidth',3)
ylabel('THETA2D - THETA2P')
title('Deduced theta2 - Predicted theta2')
saveas(1,'Inv_Kin_DataSet','jpeg')
saveas(2,'Inv_Kin_Accuracy','jpeg')
