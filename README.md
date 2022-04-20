# xstructure
A class to operate POSCAR using MATLAB


Originally written by Prof. Kesong YANG (kesong@ucsd.edu) at UC San Diego for NANO106 Crystalgraphy of Materials in 2020-03-16
Developed based on the class "xstructure" in AFLOW (writen in c++) and Aflowpy (python-based xstructure)  
Current version only supports POSCAR in vasp5 format


%Usage examples: 
%Read a POSCAR:  a = xstructure('SrTiO3.vasp')

%Print POSCAR: dispstr(a)

%Write POSCAR as b.vasp: writestr(a,'b.vasp')
