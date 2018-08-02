function [cluster,type]=dbscan(D,Eps,MinPts)
    
    %----Initializations----
    visited=zeros(size(D,1),1);
    type=ones(size(D,1),1); %core=1;border=0,noise=-1
    cluster=zeros(size(D,1),1);
    %-----------------------
    
    c=0;
    for i=1:size(D,1)
        if visited(i) continue;end
        visited(i)=1;
        neighborIndices=getNeighbors(D,i,Eps);
        if length(neighborIndices)<MinPts
            type(i)=-1;
        else
            c=c+1;
            type(i)=1;
            %expand cluster to include density connected points
            [cluster,visited,type]=expandCluster(D,i,neighborIndices,c,Eps,MinPts,cluster,visited,type);
        end
    end
end
function [cluster,visited,type]=expandCluster(D,currentIndex,neighborIndices,c,Eps,MinPts,cluster,visited,type)
    cluster(currentIndex)=c;    
    i=1;
    while i<=length(neighborIndices)
        if ~visited(neighborIndices(i))
            visited(neighborIndices(i))=1;
            secondNeighborIndices=getNeighbors(D,neighborIndices(i),Eps);
            if length(secondNeighborIndices)>=MinPts
                neighborIndices=([neighborIndices;secondNeighborIndices]);
                type(neighborIndices(i))=1;
            else                
                type(neighborIndices(i))=0;
            end
        end
        if cluster(neighborIndices(i))==0
            cluster(neighborIndices(i))=c;
        end
        i=i+1;
    end
end
%This function calculates the Euclidean distance and return the neighbors
function neighborIndices=getNeighbors(D,i,Eps)
    [m,n]=size(D);
    EuqDistance=sqrt(sum((ones(m,1)*D(i,:)-D).^2,2));
    indices=find(EuqDistance<=Eps);
    neighborIndices=setdiff(indices,i);    
end