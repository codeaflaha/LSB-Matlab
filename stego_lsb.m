% ===========================
% Program Steganografi citra dengan LSB
%============================
clc;
clear all;
close all;
Pesan=input('masukkan Pesan [maksimal 20 karakter] : ','s');
if length(Pesan) > 20, Pesan=Pesan(1:20), end;
Pesan=uint8(Pesan);
panjang_pesan=length(Pesan);
citra=imread('lena.jpg');
if size(citra,3)==3
	citra=rgb2gray(citra);
end;
citra=imresize(citra,[256 312]);
[baris,kolom]=size(citra);
stego=citra(:);

%pesan jadi biner
bit_pesan=[];
for i=1:panjang_pesan
biner=dec2bin(Pesan(i),8);
bit_pesan=[bit_pesan biner];
end
panjang_bit_pesan=length(bit_pesan);

%Penyisipan Pesan

for i=1:panjang_bit_pesan
	if (mod(stego(i),2)==0) & (bit_pesan(i) =='1')
	stego(i)=stego(i)+1;
    end
    
    if (mod(stego(i),2)==1) & (bit_pesan(i) =='0')
	stego(i)=stego(i)-1;
	end
end

stego=reshape(stego, [baris kolom]);

subplot(1,2,1), imshow(citra), title('Citra asli');
subplot(1,2,2), imshow(stego), title('citra stego');


%Ektraksi Pesan

stego=stego(:);
bitpesan=[];
for i=1:panjang_bit_pesan
	if mod(stego(i),2) == 0, bitpesan=[bitpesan '0'];
	end;
	if mod(stego(i),2) == 1, bitpesan=[bitpesan '1'];
    end
end

Pesan=[];
for i=1:8:panjang_bit_pesan
desimal=bin2dec(bitpesan(i:i+7));

	Pesan=[Pesan char(desimal)];
	
end

disp(['hasil ekstraksi pesan =', Pesan])
