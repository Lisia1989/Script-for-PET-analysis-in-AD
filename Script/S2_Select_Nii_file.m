%把每个被试的nii文件挑出来，并重命名
%Xuanyu Li
%20190710

PETPath=uigetdir(pwd,'Please choose the PET folder');
index_dir=findstr(PETPath,filesep);
OutPath=PETPath(1:index_dir(end)-1);
Output=[OutPath, filesep, 'Output'];
if exist(Output, 'dir')~=7
   mkdir(Output);
end
SubID=dir(PETPath); 
if strcmp(SubID(3).name,'.DS_Store')
    SubID(3)=[];
end
SubID=SubID(3:end);
for i=1:size(SubID,1);
    NiiFile=spm_select('FPList',[PETPath,filesep, SubID(i).name],'^sw.*\.nii$');
    %NiiFile=dir([PETPath,filesep, SubID(i).name]);
    %NiiFile=NiiFile(3:end);
    %OldPath=[PETPath,filesep, SubID(i).name,filesep,'sw*.nii'];
    
    NewPath=[Output, filesep,'sw',SubID(i).name,'.nii' ];
    copyfile(NiiFile,NewPath);
end