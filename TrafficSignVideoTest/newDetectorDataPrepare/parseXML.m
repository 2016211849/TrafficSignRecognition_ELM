%param:
%index:��i���ļ��м����Ӧ��xml�ļ�����120����

function data = parseXML(index,imgWidth,imgHeight)
    xmlPath=['..\detectorTrainingFiles\����������ݼ�\ѵ�����ݼ�-2016.07.27.release\TSD-Signal-GT\TSD-Signal-',num2str(index,'%05d'),'-GT.xml'];
    xDoc=xmlread(xmlPath);
    globalIndex=0;
    label_globalIndex=0;
    imgeFilename={};
    objectBoundingBoxes={};
    %get the type label
    typeContenList=xDoc.getElementsByTagName('Type');
    %get the Position label
    positionContenList=xDoc.getElementsByTagName('Position');
    
    
    % get frame number
    frameNumber=str2num(xDoc.getElementsByTagName('FrameNumber').item(0).getFirstChild.getData);
    
    for frameIndex=0:frameNumber-1
        currentFrameIndexStr=num2str(frameIndex,'%05d');
        currentFrameTargetNumStr=['Frame',currentFrameIndexStr,'TargetNumber'];
        currentFrameTargetNum=str2num(xDoc.getElementsByTagName(currentFrameTargetNumStr).item(0).getFirstChild.getData);
        
        %get every target label
        for targetIndex=0:currentFrameTargetNum-1
              position=positionContenList.item(globalIndex).getFirstChild.getData;
              type=typeContenList.item(globalIndex).getFirstChild.getData;
              globalIndex=globalIndex+1;
              imgPath=['E:\BaiduYunDownload\����������ݼ�\ѵ�����ݼ�-2016.07.25.release\TSD-Signal_part03\TSD-Signal\TSD-Signal-',num2str(index,'%05d'),'\TSD-Signal-',num2str(index,'%05d'),'-',num2str(frameIndex,'%05d'),'.png'];
              
              position_char=char(position);
              S = regexp(position_char, '\s+', 'split');%get the rectangle coordinate
              %��ע�ļ���ͼ�������0��ʼ���㣬��matlab���Ǵ�1��ʼ
              X=str2num(S{2})+1;
              Y=str2num(S{3})+1;
              boxWidth=str2num(S{4});
              boxHeight=str2num(S{5});
              
              %��ֹ��׼�ļ����ı�ע�����Խ��
              if X+boxWidth>imgWidth
                boxWidth=imgWidth-X;
              end
              if Y+boxHeight>imgHeight
                boxHeight=imgHeight-Y;
              end
             
              boundingBox=[X,Y,boxWidth,boxHeight];
              bo=isLightType(type);% bo==1,means the type is TL
              if boundingBox(3)*boundingBox(4)>256&&bo==0
                  label_globalIndex=label_globalIndex+1;
                  imgeFilename{label_globalIndex}=imgPath;  
                  objectBoundingBoxes{label_globalIndex}=boundingBox;
              end
        end
        
        data=struct('imageFilename',imgeFilename,'objectBoundingBoxes',objectBoundingBoxes);
    
    end
end



