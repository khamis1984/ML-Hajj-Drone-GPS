%------------Load Clu Data----------------
data=textread('clu_data.txt');

%----Call dbscan clustering function------
MinPts=5;Eps=2.1;  %MinPts is the number of neighbors in the cluster and eps is the radius
[cluster,type]=dbscan(data,Eps,MinPts);
kc=(unique(cluster));
figure(1);%colors={'b.','r.','y.','g.','m.','c.','k.','w.','b.','b.','b.','b.','b.','b.'};
colors={[0 0 0],[0 0 1],[1 0 0],[1 1 0],[1 0 1],[0 1 0],[0 1 1],[1 0.3 0.63],[0.5 0.7 0.5],[0.45 0.25 0.75],[0.75 0.55 0.75],[0.9 0.7 0.6],[0.9 0.3 0.6],[0.3 0.5 0.9],[0.45 0.2 0.9],[0.25 0.9 0.3],[0.75 0.5 0.82],[0.12 0.18 0.82]};
for i=1:length(kc)
    c1=find(cluster==kc(i));
    plot(data(c1,1),data(c1,2),'Marker','.','LineStyle','none','Color',colors{i});hold on;
    axis([-26 16 -15 15])
end
numOfCore=sum(type==1);
numOfBorder=sum(type==0);
numOfOutlier=sum(type==-1);