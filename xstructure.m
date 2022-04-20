classdef xstructure
%{ 
Written by Prof. Kesong YANG (kesong@ucsd.edu) at UC San Diego for NANO106 Crystalgraphy of Materials
Developed based on the class "xstructure" in AFLOW (c++) and Aflowpy (python-based xstructure)  
Current version only supports POSCAR in vasp5 format
2020-03-16
%usage examples:
a = xstructure('SrTiO3.vasp')

%Print POSCAR
dispstr(a)

%Write POSCAR as b.vasp
writestr(a,'b.vasp')

%}
   properties
      title = 'untitled';
      scale = 1.0;
      lattice = [];
      species = [];
      num_each_type = [];
      isDirect = false;
      isCart = false;
      coord_type = "Direct";
      natm = 0;
      coord =[];  %fractional or cartesian
      %atoms;
   end
   methods
       function obj = xstructure(vaspFile)
          lines = readlines(vaspFile, "EmptyLineRule", "skip");
          obj.title = string(lines(1));
          obj.scale = double(lines(2)); 
          obj.lattice = str2lattice(lines(3:5));
          obj.species = string(split(strtrim(lines(6))));
          obj.num_each_type = str2vec(lines(7));
          t = char(lines(8));
          % direct
          obj.isDirect = strcmp(t(1),'D') | strcmp(t(1),'d');
          if obj.isDirect
              obj.coord_type = "Direct";
              obj.coord = str2coord(lines(9:end));
          end
          % direct
          % cartesian
          obj.isCart = strcmp(t(1),'C') | strcmp(t(1),'c');
          if obj.isCart
              obj.coord_type = "Cartesian";
              obj.coord = str2coord(lines(9:end));
          end
          % cartesian
          obj.natm = size(obj.coord, 1);
       end
       
       function dispstr(obj)
           printstr(obj, 1);
       end
       
       function writestr(obj, ofile)
           fileID = fopen(ofile,'w');
           printstr(obj, fileID);
       end
       
   end
end

function mat = str2lattice(lines)
mat = zeros(3,3);
for i = 1:3
    for j=1:3
        newLine = split(strtrim(lines(i)));
        mat(i,j) = double(newLine(j));
    end
end
end

function vec = str2vec(line)
str = split(strtrim(line));
vec = zeros(1,length(str));
for i=1:length(str)
    vec(i) = int32(str2double(str(i)));
end
end

function mat = str2coord(lines)
natm = length(lines);
mat = zeros(natm, 3);
for i = 1:natm
    for j=1:3
        newLine = split(strtrim(lines(i)));
        mat(i,j) = double(newLine(j));
    end
end
end


function printstr(obj, fileID)
%print vasp file
fprintf(fileID, "%s\n", obj.title);
fprintf(fileID, "%f\n", obj.scale);
for i = 1:3
    for j = 1:3
        fprintf(fileID, "%-18.12f", obj.lattice(i,j));
    end
    fprintf(fileID, "\n");
end
for i = 1:length(obj.species)
    fprintf(fileID, "%-6s", obj.species(i));
end
fprintf(fileID, "\n");
for i = 1:length(obj.num_each_type)
    fprintf(fileID, "%-6d", obj.num_each_type(i));
end
fprintf(fileID, "\n");
fprintf(fileID, "%s\n", obj.coord_type);

for i = 1:obj.natm
    for j=1:3
        fprintf(fileID, "%-18.12f", obj.coord(i,j));
    end
    fprintf(fileID, "\n");
end

end


