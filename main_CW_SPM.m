clc;clear;close all;

load('optLibs.mat');
%Open start file, where the scheme will be drawn
directory = fullfile(pwd,'CW_SPM.osd');
optsys = OpenOptisystem(directory);

%Get main system variables
Document = optsys.GetActiveDocument;
LayoutMgr = Document.GetLayoutMgr;
Layout = LayoutMgr.GetCurrentLayout;
Canvas = Layout.GetCurrentCanvas;
PmMgr = Layout.GetParameterMgr;

Las1 = Canvas.GetComponentByName('CW Laser');
Las2 = Canvas.GetComponentByName('CW Laser_1');
Ampl = Canvas.GetComponentByName('Optical Amplifier');
Fiber = Canvas.GetComponentByName('Optical Fiber');
OSA = Canvas.GetComponentByName('Optical Spectrum Analyzer');
OPM = Canvas.GetComponentByName('Optical Power Meter');

Document.CalculateProject(true,true);
GraphSSP = OSA.GetGraph("Sampled signal spectrum");
NumberOfPoints = GraphSSP.GetNrOfPoints;
XData = zeros(NumberOfPoints,1);
YData = zeros(NumberOfPoints,1);

for q = 1:NumberOfPoints-1
    XData(q) = GraphSSP.GetXDataAt(q,1);
    YData(q) = GraphSSP.GetYDataAt(q,1);
end
optsys.Quit();
plot(XData,YData)