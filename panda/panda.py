#!/usr/bin/python

import os
import sys, traceback

def main():
	try:
		print '''
=======================================================================
============Welcome to add tools kali linux for ubuntu=================
==========================created by Panda=============================
================== blog : http://mas-linux.blogspot.com ===============
=============== Email me : Hidayatullah.afif@yahoo.co.id ==============
=======================================================================
                               Vbeta \033[1;m
 \033[1;32m+ -- -- +=[ Author: Panda | Blog: mas-linux.blogspot.com+ -- -- +=\033[1;m
 \033[1;32m+ -- -- +=[ kali linux tools Tools + -- -- +=\033[1;m
			'''
		def inicio1():
			while True:
				print '''
1. Add Key and repo KaliLInux
2. Install tools bonus
3. Install menu kali-linux
4. Help and Note(BACA DULU)
			'''

				opcion0 = raw_input("\033[1;36mPanda |-$ \033[1;m")
			
				while opcion0 == "1":
					print '''
1. Add kali linux repositories
2. Update
3. Open Synaptic package manager for Manual install tools
4. Remove kali linux repositories
5. View the contents of sources.list file
					'''
					repo = raw_input("\033[1;32mSilahkan pilih salah satu+++>|-$ \033[1;m")
					if repo == "1":
						cmd1 = os.system("wget -q -O - http://panda-tools.comlu.com/kali.pgp | sudo apt-key add -")
						cmd2 = os.system("echo '# Kali linux repositories | Added by Panda\ndeb http://ppa.launchpad.net/wagungs/kali-linux2/ubuntu raring main\ndeb-src http://ppa.launchpad.net/wagungs/kali-linux2/ubuntu raring main\ndeb http://ppa.launchpad.net/wagungs/kali-linux/ubuntu raring main\ndeb-src http://ppa.launchpad.net/wagungs/kali-linux/ubuntu raring main\ndeb http://ppa.launchpad.net/wagungs/kali-linux1/ubuntu raring main\ndeb-src http://ppa.launchpad.net/wagungs/kali-linux1/ubuntu raring main\n' >> /etc/apt/sources.list")
					elif repo == "2":
						cmd3 = os.system("apt-get update -m")
					elif repo == "3":
						cmd3 = os.system("sudo apt-get install synaptic")
						cmd4 = os.system("synaptic")
					elif repo == "4":
						infile = "/etc/apt/sources.list"
						outfile = "/etc/apt/sources.list"

						delete_list = ["# Kali linux repositories | Added by Panda\n", "deb http://ppa.launchpad.net/wagungs/kali-linux2/ubuntu raring main","deb-src http://ppa.launchpad.net/wagungs/kali-linux2/ubuntu raring main","deb http://ppa.launchpad.net/wagungs/kali-linux/ubuntu raring main","deb-src http://ppa.launchpad.net/wagungs/kali-linux/ubuntu raring main","deb http://ppa.launchpad.net/wagungs/kali-linux1/ubuntu raring main","deb-src http://ppa.launchpad.net/wagungs/kali-linux1/ubuntu raring main"]
						fin = open(infile)
						os.remove("/etc/apt/sources.list")
						fout = open(outfile, "w+")
						for line in fin:
						    for word in delete_list:
						        line = line.replace(word, "")
						    fout.write(line)
						fin.close()
						fout.close()
						print " "
						print "\033[1;31mAll kali linux repositories have been deleted !\033[1;m"
						print " "
					elif repo == "back":
						inicio1()
					elif repo == "gohome":
						inicio1()
					elif repo == "5":
						file = open('/etc/apt/sources.list', 'r')

						print file.read()

					else:
						print ("\033[1;31mSorry, perintah seng koe masukan salah cok!!\033[1;m")  					
						
						
				if opcion0 == "3":
					repo = raw_input("\033[1;32mDo you want to install Kali menu and indicator ? [y/n]> \033[1;m")
					if repo == "y":
						cmd1 = os.system("add-apt-repository ppa:diesch/testing && apt-get update")
						cmd2 = os.system("sudo apt-get install classicmenu-indicator")
						cmd3 = os.system("apt-get install kali-menu")
				elif opcion0 == "4":
					print ''' 
****************** +Commands+ ****************** 
\033[1;32mpilih angka yang disediakan\033[1;m 	
\033[1;32mketik back jika ingin kembali\033[1;m 	
\033[1;32mketik gohome kalau mau kembali ke menu awal \033[1;m 	
\033[1;32mketik grab back kalo mau salah\033[1;m 	
\033[1;32mnjir mau aja u baca ini\033[1;m	
****************** +Note+ ****************** 
\033[1;32mJika anda menginstall tools dengan otomatis\033[1;m 	
\033[1;32mdan mengalami masalah setelahnya maka admin tidak bertanggung jawab\033[1;m 	
\033[1;32mJadi disarankan coba lah dengan manual yang tersedia di pilihan 1 \033[1;m 	
\033[1;32mkarena yang manual itu lebih murni jika ada kesalahan bisa di cegah\033[1;m 	
\033[1;32mSederhana itu indah bro Njir..!!!\033[1;m	
		'''


				def inicio():
					while opcion0 == "2":
						print '''
\033[1;36mAll Tools\033[1;m	
				
\033[1;32mwifresti\033[1;m			
\033[1;32msquid3\033[1;m			

				
1) Install All Tools
			 '''
						print "\033[1;32mPilih Nomer 1 Jika anda yakin untuk menginstall seluruh tools.\033[1;m"

						print " "
						opcion1 = raw_input("\033[1;36mPanda |-$  \033[1;m")
						if opcion1 == "back":
							inicio1()
						elif opcion1 == "gohome":
							inicio1()
						elif opcion1 == "1":
							cmd1 = os.system("git clone https://github.com/LionSec/wifresti.git && cp wifresti/wifresti.py /usr/bin/wifresti && chmod +x /usr/bin/wifresti && wifresti")
							cmd2 = os.system("apt-get install squid3")
							print " "
						elif opcion2 == "back":
								inicio()
						elif opcion2 == "gohome":
								inicio1()
						
				inicio()
		inicio1() 

	except KeyboardInterrupt:
		print "Cencel"
	except Exception:
		traceback.print_exc(file=sys.stdout)
	sys.exit(0)

if __name__ == "__main__":
    main()					
						
