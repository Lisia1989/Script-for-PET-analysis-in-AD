% This code is used for calculate SUVR by voxel.
%Reference region:Whole_Cerebellum;
%Date: 20181214

%%  initialization
clear all; close all; clc;
GlobalSuvr={};
%% T1 information needed
GlobalSuvr{1,1}='SubID'; GlobalSuvr{1,2}='tracer';GlobalSuvr{1,3}='GlobeMeanSuvr';

load('Whole_Cerebellum.mat');%load Whole_Cerebellum mask(CereMask);
%load('WholeBrain.mat');
PETPath=uigetdir(pwd,'Please choose the PET folder');
PETSubjects=dir(PETPath); 
if strcmp(PETSubjects(3).name,'.DS_Store')
    PETSubjects(3)=[];
end
PETSubjects=PETSubjects(3:end);
for i=1:size(PETSubjects,1);
    PETSubjectPath=[PETPath,filesep,PETSubjects(i).name];
    PETFile=spm_select('FPList',[PETSubjectPath],'^sw.*\.nii$');
    PETinfo=spm_vol(PETFile);
    PET=spm_read_vols(PETinfo);
    %SUVR
    CereSuv=mean(PET(find(CereMask)));
    PETinfo.fname=[PETSubjectPath,filesep,PETSubjects(i).name,'_divWCere.nii'];
    PETinfo.dt=[16 0];
    SUVRinfo=spm_write_vol(PETinfo,PET/CereSuv);
    SUVR=spm_read_vols(SUVRinfo);
end
%% write the imaging parameters into excel files
%OutputPath=[PETPath,filesep, 'GLobalSuvr.xlsx'];
%xlswrite(OutputPath, GlobalSuvr,'GolbalSuvr' );
