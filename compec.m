function varargout = compec(varargin)
% COMPEC M-file for compec.fig
%      COMPEC, by itself, creates a new COMPEC or raises the existing
%      singleton*.
%
%      H = COMPEC returns the handle to a new COMPEC or the handle to
%      the existing singleton*.
%
%      COMPEC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPEC.M with the given input arguments.
%
%      COMPEC('Property','Value',...) creates a new COMPEC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before compec_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to compec_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help compec

% Last Modified by GUIDE v2.5 03-Dec-2016 02:24:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @compec_OpeningFcn, ...
    'gui_OutputFcn',  @compec_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before compec is made visible.
function compec_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to compec (see VARARGIN)
%axes(handles.axes1);
%axis off;
% Choose default command line output for compec
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes compec wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = compec_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.jpg;*.png;','Select Image');

if (FileName)==0
    return
end

%enableButtons(handles);

FullPathName = [PathName,FileName];
image=imread(FullPathName);
axes(handles.axes1);
%a1=axes;
imshow(imread(FullPathName));
%image(imread(FullPathName))

col=size(imread(FullPathName),1);
rows=size(imread(FullPathName),2);
set(handles.text6,'String',col);
set(handles.text4,'String',rows);
set(handles.text7,'String',FullPathName);


% --------------------------------------------------------------------
function Remove_Object_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.*','Select Image');

if (FileName)==0
    return
end

%enableButtons(handles);

FullPathName = [PathName,'\',FileName];
image=imread(FullPathName);
axes(handles.axes1);
%a1=axes;
%imshow(imread(FullPathName),handles.axes1);
%image(imread(FullPathName))

col=size(imread(FullPathName),1);
rows=size(imread(FullPathName),2);
set(handles.text6,'String',col);
set(handles.text4,'String',rows);
set(handles.text7,'String',FullPathName);

%FullPathName=get(handles.text7,'String');
pixel=get(handles.txtpixels,'String');
pixel=str2num(pixel);
pixel=80;
%z=get(handles.radio_height,'Value');

%script4vertical(FullPathName,pixel)
guidata(hObject, handles);
%% funkaari

clc;
%%name of image
%name=image;
%name='man.png';

pixels=50;

inputImage=(imread(FullPathName));

%inputImage=imresize(inputImage,[ NaN 200]);
%I1=inputImage(col,rows,1);
%figure; imshow(I1)



%Mask=roipoly(inputImage);
Mask=roipoly(inputImage);
%figure
%imshow(Mask);
%figure
grayImage=double(rgb2gray(inputImage)); %get the grayscale image

n=pixels;
%%
for i=1:n
    ENERGY_IMG=getEnergyImage(grayImage); %%apply sobel filter to get Gradient Image
    % set values of selected pixels to a small number
    
    for i=1:size(Mask,1)
        for j=1:size(Mask,2)
            if(Mask(i,j) ~= 0 )
                ENERGY_IMG(i,j)=-200;
            end
        end
    end
    
    
    seamVector=findSeam(ENERGY_IMG); %find a seam vector from the given energy map
    
    %Remove seam from original image
    inputImage = removeSeam(inputImage,seamVector);
    Mask=removeSeam(Mask,seamVector);
    %Remove Seam from grayImage too
    grayImage=removeSeam(grayImage,seamVector);
end
%axes(handles.axes2);
%axes(axes2)
positionss=[429 239 308 285];
axes(handles.axes2);
%axes('position',positionss)
%inputImage=imresize(inputImage,[NaN 240-pixels]);
%inputImage=inputImage+[
xlabel('Final Image'),imshow(uint8(inputImage));


%%---




%%funkaari

% hObject    handle to Remove_Object (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Preserve_Object_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.*','Select Image');

if (FileName)==0
    return
end

%enableButtons(handles);

FullPathName = [PathName,'\',FileName];
image=imread(FullPathName);
axes(handles.axes1);
%a1=axes;
imshow(imread(FullPathName),handles.axes1);
%image(imread(FullPathName))

col=size(imread(FullPathName),1);
rows=size(imread(FullPathName),2);
set(handles.text6,'String',col);
set(handles.text4,'String',rows);
set(handles.text7,'String',FullPathName);
% hObject    handle to Preserve_Object (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Propotionate_Resize_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.*','Select Image');

if (FileName)==0
    return
end

%enableButtons(handles);

FullPathName = [PathName,'\',FileName];
image=imread(FullPathName);
axes(handles.axes1);
%a1=axes;
imshow(imread(FullPathName),handles.axes1);
%image(imread(FullPathName))

col=size(imread(FullPathName),1);
rows=size(imread(FullPathName),2);
set(handles.text6,'String',col);
set(handles.text4,'String',rows);
set(handles.text7,'String',FullPathName);
% hObject    handle to Propotionate_Resize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Save_Output_Callback(hObject, eventdata, handles)
% hObject    handle to Save_Output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function CAIM_Callback(hObject, eventdata, handles)
% hObject    handle to CAIM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Reduce_Height_Callback(hObject, eventdata, handles)
set(handles.pushbutton2,'Visible','on');
set(handles.txtpixels,'Visible','on');
set(handles.text2,'Visible','on');
[FileName,PathName] = uigetfile('*.*','Select Image');

if (FileName)==0
    return
end

%enableButtons(handles);

FullPathName = [PathName,'\',FileName];
image=imread(FullPathName);
axes(handles.axes1);
%a1=axes;
imshow(imread(FullPathName),handles.axes1);
%image(imread(FullPathName))

col=size(imread(FullPathName),1);
rows=size(imread(FullPathName),2);
set(handles.text6,'String',col);
set(handles.text4,'String',rows);
set(handles.text7,'String',FullPathName);


% hObject    handle to Reduce_Height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Reduce_Width_Callback(hObject, eventdata, handles)

set(handles.pushbutton2,'Visible','on');
set(handles.txtpixels,'Visible','on');
set(handles.text2,'Visible','on');

[FileName,PathName] = uigetfile('*.*','Select Image');

if (FileName)==0
    return
end

%enableButtons(handles);

FullPathName = [PathName,'\',FileName];
image=imread(FullPathName);
axes(handles.axes1);
%a1=axes;
imshow(imread(FullPathName),handles.axes1);
%image(imread(FullPathName))

col=size(imread(FullPathName),1);
rows=size(imread(FullPathName),2);
set(handles.text6,'String',col);
set(handles.text4,'String',rows);
set(handles.text7,'String',FullPathName);


% hObject    handle to Reduce_Width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function txtpixels_Callback(hObject, eventdata, handles)
% hObject    handle to txtpixels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtpixels as text
%        str2double(get(hObject,'String')) returns contents of txtpixels as a double


% --- Executes during object creation, after setting all properties.
function txtpixels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtpixels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
FullPathName=get(handles.text7,'String');
pixel=get(handles.txtpixels,'String');
pixel=str2num(pixel);
%z=get(handles.radio_height,'Value');
script4vertical(FullPathName,pixel)

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function CAIM2_Callback(hObject, eventdata, handles)
% hObject    handle to CAIM2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Enlarge.
function Enlarge_Callback(hObject, eventdata, handles)
FullPathName=get(handles.text7,'String');
n=get(handles.txtpixels,'String');
n=str2num(n);
imageName=FullPathName;
z=get(handles.radioHeight,'Value');


inputImage=double(imread(imageName));
%figure,imshow(uint8(inputImage))

%n=70; %n is the number of rows to add
if(z==true)
    inputImage=imrotate(inputImage,90);
end
%%
%%apply sobel filter to get Gradient Image
ENERGY_IMG=getEnergyImage(inputImage);
for i=1:n
    %find a seam vector from the given energy map
    seamVector=findSeam(ENERGY_IMG);
    
    %add seam to the original image
    inputImage = addSeam(inputImage,seamVector);
    
    %also add seam in energy image
    ENERGY_IMG=addSeam(ENERGY_IMG,seamVector,1);
end
if(z==true)
    inputImage=imrotate(inputImage,-90);
end
axes(handles.axes2);
imshow(uint8(round(inputImage)));

% hObject    handle to Enlarge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cmdShrink.
function cmdShrink_Callback(hObject, eventdata, handles)
FullPathName=get(handles.text7,'String');
n=get(handles.txtpixels,'String');
n=str2num(n);
imageName=FullPathName;
z=get(handles.radioHeight,'Value');

inputImage=(imread(imageName));
if(z==true)
    inputImage=imrotate(inputImage,90);
end
%%
for i=1:n
    %apply sobel filter to get the gradient image
    ENERGY_IMG=getEnergyImage(inputImage);
    %find seam to be removed
    seamVector=findSeam(ENERGY_IMG);
    
    %Remove seam from original image
    inputImage = removeSeam(inputImage,seamVector);
end
if(z==true)
    inputImage=imrotate(inputImage,-90);
end

axes(handles.axes2);

imshow(uint8(inputImage));

% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cmdRemove_Object.
function cmdRemove_Object_Callback(hObject, eventdata, handles)
% hObject    handle to cmdRemove_Object (see GCBO)
FullPathName=get(handles.text7,'String');
n=get(handles.txtpixels,'String');
n=str2num(n);
imageName=FullPathName;
z=get(handles.radioHeight,'Value');

inputImage=(imread(imageName));
axes(handles.axes1);
BW = roipoly(inputImage);
% load BWx3
wpix = max(sum(BW,1));
hpix = max(sum(BW,2));
%n = max(wpix,hpix)+1;
if z
    n = wpix;
else
    n = hpix;
end
%z = wpix > hpix;
set(handles.txtpixels,'String',num2str(n))
guidata(hObject, handles);
if(z==true)
    inputImage=imrotate(inputImage,90);
    BW=imrotate(BW,90);
end

h=size(inputImage,1)+1;
%%
for i=1:n
    %%apply sobel filter to getGradient Image
    ENERGY_IMG=getEnergyImage(inputImage);
    
    ENERGY_IMG(logical(BW))=-(h)*abs(max(max(ENERGY_IMG)));
    
    %find a seam vector from thegiven energy map
    seamVector=findSeam(ENERGY_IMG);
    
    %Remove seam from original image
    inputImage = removeSeam(inputImage,seamVector);
    
    BW=removeSeam(BW,seamVector);
end
if(z==true)
    inputImage=imrotate(inputImage,-90);
end
axes(handles.axes2);
imshow(uint8(inputImage));
handles.output = inputImage;
guidata(hObject, handles);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cmdPreserve_Object.
function cmdPreserve_Object_Callback(hObject, eventdata, handles)

FullPathName=get(handles.text7,'String');
n=get(handles.txtpixels,'String');
n=str2num(n);
imageName=FullPathName;
z=get(handles.radioHeight,'Value');

inputImage=(imread(imageName));
axes(handles.axes1);
BW = roipoly(inputImage);
%z = wpix > hpix;
% load BWx3
if(z==true)
    inputImage=imrotate(inputImage,90);
    BW=imrotate(BW,90);
end

h=size(inputImage,1)+1;
%%
for i=1:n
    %%apply sobel filter to getGradient Image
    ENERGY_IMG=getEnergyImage(inputImage);
    
    ENERGY_IMG(logical(BW))=+(h)*abs(max(max(ENERGY_IMG)));
    
    %find a seam vector from thegiven energy map
    seamVector=findSeam(ENERGY_IMG);
    
    %Remove seam from original image
    inputImage = removeSeam(inputImage,seamVector);
    
    BW=removeSeam(BW,seamVector);
end
if(z==true)
    inputImage=imrotate(inputImage,-90);
end
axes(handles.axes2);
imshow(uint8(inputImage));

% hObject    handle to cmdPreserve_Object (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in saveoutput.
function saveoutput_Callback(hObject, eventdata, handles)
% hObject    handle to saveoutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uiputfile('output.jpg','Save File As');
name=fullfile(PathName,FileName);
imwrite(uint8(handles.output),name)


% --------------------------------------------------------------------
function mnuAbout_Callback(hObject, eventdata, handles)
% hObject    handle to mnuAbout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Developed by M. Rizwan, W. Malik and Dr. Fayyaz Minhas (http://faculty.pieas.edu.pk/fayyaz). Implements: Avidan, Shai, and Ariel Shamir. "Seam carving for content-aware image resizing." ACM Transactions on graphics (TOG). Vol. 26. No. 3. ACM, 2007.' ,'About COMPEC');


% --- Executes on key press with focus on pushbutton2 and none of its controls.
function pushbutton2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
