function BCFD = FD(x)
%%https://apexpg.jimdofree.com/matlab-file/fractal-dimension/
x          = x+abs(min(x));
x          = [x/max(x)'].*length(x);
L          = length(x);
k1         = 1;
mm         = 1:30;

for m      = floor(L./mm)
    if m < 2
        break
    end
    Lbx    = m;
    Lby    = m;
    Mcover = zeros(mm(k1)+1,mm(k1)+1);
    k2     = 1;
    for j  = 0:mm(k1)
        if j == mm(k1)
            z  = x(j*Lbx:L);
            Fl = [L-j*Lbx]/floor(L./mm(k1));
        else
            z  = x(j*Lbx+2:(j+1)*Lbx);
        end
        k3    = 0;
        for l = 1:mm(k1)+1
            f = find(z>(l-1)*Lby & z<l*Lby);
            if sum(f)>0
                Mcover(mm(k1)+1-k3,k2)=1;
            end
            k3 = k3+1;
        end
        k2  = k2+1;
    end
    nf      = Fl*sum(Mcover(:,mm(k1)+1))+sum(Mcover(mm(k1)+1,:));
    Mcoverm = Mcover([1:mm(k1)],[1:mm(k1)]);
    lm(k1)  = log10(1/(mm(k1)));
    lmc(k1) = log10(nf+sum(sum(Mcoverm)));
    k1      = k1+1;
    clear Mcover
end
[BCFD,~]    = LSE(lm,lmc);
% figure('color','w')
% plot(lm,lm*BCFD+b,'g','LineWidth',2);hold on;grid on
% title(['BCFD = ',num2str(BCFD)])
% ylabel('log_1_0(r(k))')
% xlabel('log_1_0(k)')
% plot(lm,lmc,'*')
BCFD = abs(BCFD);
end
