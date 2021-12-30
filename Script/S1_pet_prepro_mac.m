% This code is used for preprocess the PET images to MNI. Steps include:
%1. Coregistered T1 images to PET images and reslice 
%2. Segment the coregistered T1 images and obtain the forward and inverse deformation
%3. Normalize the PET images with the forward deformation
%4. Smooth the normalized PET images
%Author: Li Xuanyu
%Date: 20181212

%%  initialization
clear all; close all; clc;
PETPath=uigetdir(pwd,'Please choose the PET folder');
T1Path=uigetdir(pwd,'Please choose the coregistered T1 folder');


for T1Subjects=dir(T1Path); 
    if strcmp(T1Subjects(3).name,'.DS_Store')
        T1Subjects(3)=[];
    end
    T1Subjects=T1Subjects(3:end); 
    PETSubjects=dir(PETPath); 
    if strcmp(PETSubjects(3).name,'.DS_Store')
        PETSubjects(3)=[];
    end
    PETSubjects=PETSubjects(3:end);
    parfor i=1:size(T1Subjects,1);
        T1SubjectPath=[T1Path,filesep,T1Subjects(i).name];
        T1Filename=dir([T1SubjectPath,filesep,'o*.nii']);%not co this code;
        T1File=[T1SubjectPath,filesep,T1Filename.name];
        PETSubjectPath=spm_select('FPListRec',PETPath,'dir',T1Subjects(i).name);%subjects.name must be same in both t1 and pet folder;
        PETFile=spm_select('ExtFPListRec',[PETSubjectPath],'.nii');
        pet_prepro_win_job(PETFile,T1File);
    end
end