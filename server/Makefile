# 项目环境


.PHONY : help

.PHONY : test

.PHONY : all clean
.PHONY : sock dbx session gateway world 

.PHONY : config
.PHONY : lua tolua ldconfig limits 
.PHONY : tags systags

.PHONY : start stop

# 帮助
help :
	@echo "this is the help of the Makefile.."
	@echo "all of the targets is :"
	@echo ""
	@echo "test :"
	@echo "run two test program(test_client and test_server)"
	@echo ""
	@echo "all :"
	@echo "build the solution"
	@echo ""
	@echo "clean"
	@echo "clean the solution"
	@echo ""
	@echo "sock dbx session gateway world :"
	@echo "the sub projects"
	@echo ""
	@echo "config :"
	@echo "setup the env of development"
	@echo ""
	@echo "lua tolua ldconfig limits :"
	@echo "the sub env of development"
	@echo ""
	@echo "tags systags :"
	@echo "create tags"
	@echo ""
	@echo "start :"
	@echo "start the server"
	@echo ""
	@echo "stop :"
	@echo "stop the server"


# 测试程序
test :
	@echo ""
	cd mak.d; make -f test_client.mak
	@echo ""
	cd mak.d; make -f test_server.mak
	@echo ""


# 编译
all : sock session gateway world

clean :
	rm -rf ./sbin/temp

sock :
	@echo ""
	cd mak.d; make -f sock.mak
	@echo ""

session :
	@echo ""
	cd mak.d; make -f session.mak
	@echo ""

gateway :
	@echo ""
	cd mak.d; make -f gateway.mak
	@echo ""

world :
	@echo ""
	cd mak.d; make -f world.mak
	@echo ""


# 安装环境
config : lua tolua db

lua :
	cd ./tools/lua-5.1.5; make clean; make linux; make install

tolua :
	cd ./tools/toluapp-1.0.93; scons -c; scons; scons install

db :
	cd ./tools/dbClient; make

ldconfig :
	cd /etc/ld.so.conf.d && touch devel.conf; echo /usr/local/lib >devel.conf
	ldconfig

limits :
	echo "" >>/etc/security/limits.conf
	echo "*               soft    core            0" >>/etc/security/limits.conf
	echo "*               hard    core            unlimited" >>/etc/security/limits.conf

tags :
	@echo "当前工作目录: $(shell pwd)"
	@rm -rf $(shell pwd)/codes/tags
	ctags -R -f $(shell pwd)/codes/tags $(shell pwd)/codes/* $(shell pwd)/../share/*.h

systags :
	@mkdir -p /systags
	ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=c++ -f /systags/c++ /usr/include/c++/4.4.7
	ctags -I __THROW -I __attribute_pure__ -I __nonnull -I __attribute__ --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q  -f /systags/sys /usr/include/* /usr/include/sys/* /usr/include/bits/*  /usr/include/netinet/* /usr/include/arpa/* /usr/include/mysql/*


# 运行
start :
	@cd sbin/linux; make --no-print-directory -f Makefile all

stop :
	@cd sbin/linux; make --no-print-directory -f Makefile clean
