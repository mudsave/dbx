
WORK_DIR = $(shell pwd)
$(info --current work dir is : $(WORK_DIR))

export LD_LIBRARY_PATH = $(WORK_DIR)

SERVER_IP = 172.16.2.218
DB_IP = 172.16.2.217
DB_PORT = 3007

.PHONY: clean start_server test
.PHONY: longxiaoquan zhangyang xuwenkai liushuojing hejialiang penghaijun
.PHONY: liyao yangyang wangzhicheng wangmeisu caiyuchao  guoyiying
.PHONY: guocanghai chendong huangxiaokun zhouying

test:
	@echo $(WORK_DIR)

clean :
	@set -e; ./kill_server
	@echo "--server is clean.."
	@sleep 3s

longxiaoquan: START_PORT=50000
longxiaoquan: start_server

zhangyang: START_PORT=50010
zhangyang: start_server

xuwenkai: START_PORT=50020
xuwenkai: start_server

liushuojing: START_PORT=50030
liushuojing: start_server

hejialiang: START_PORT=50040
hejialiang: start_server

penghaijun: START_PORT=50050
penghaijun: start_server

liyao: START_PORT=50060
liyao: start_server

yangyang: START_PORT=50070
yangyang: start_server

wangzhicheng: START_PORT=50080
wangzhicheng: start_server

wangmeisu: START_PORT=50090
wangmeisu: start_server

caiyuchao: START_PORT=50110
caiyuchao: start_server

guoyiying: START_PORT=50120
guoyiying: start_server

guocanghai: START_PORT=50130
guocanghai: start_server

chendong: START_PORT=50140
chendong: start_server

huangxiaokun: START_PORT=50150
huangxiaokun: start_server

zhouying: START_PORT=50160
zhouying: start_server


start_server:
	@SCL_PORT=$(START_PORT); \
	SGL_PORT=$$((SCL_PORT+1)); \
	SWL_PORT=$$((SCL_PORT+2)); \
	GCL_PORT=$$((SCL_PORT+3)); \
	GWL_PORT=$$((SCL_PORT+4)); \
	WAL_PORT=$$((SCL_PORT+5)); \
	FAL_PORT=$$((SCL_PORT+6)); \
	SAL_PORT=$$((SCL_PORT+7)); \
	set -e; ulimit -c unlimited; \
	($(WORK_DIR)/Session -loginAddrL $(SERVER_IP):$$SCL_PORT -gateAddrL $(SERVER_IP):$$SGL_PORT -worldAddrL $(SERVER_IP):$$SWL_PORT -dbAddrC $(DB_IP):$(DB_PORT) \
		1>$(WORK_DIR)/logs/_session.txt 2>&1 & ); \
	echo "Session has been runned.."; sleep 2s;\
	($(WORK_DIR)/Gateway -loginAddrL $(SERVER_IP):$$GCL_PORT -worldAddrL $(SERVER_IP):$$GWL_PORT -sessionAddrC $(SERVER_IP):$$SGL_PORT -gatewayId 0 \
		1>$(WORK_DIR)/logs/_gateway.txt 2>&1 & ); \
	echo "gateway has been runned.."; sleep 2s;\
	($(WORK_DIR)/World -sessionAddrC $(SERVER_IP):$$SWL_PORT -dbAddrC $(DB_IP):$(DB_PORT) -worldId 0 -adminAddrL $(SERVER_IP):$$WAL_PORT \
		1>$(WORK_DIR)/logs/_world.txt 2>&1 & ); \
	echo "world has been runned.."; sleep 2s;\
	($(WORK_DIR)/World -sessionAddrC $(SERVER_IP):$$SWL_PORT -dbAddrC $(DB_IP):$(DB_PORT) -worldId 100 -adminAddrL $(SERVER_IP):$$FAL_PORT \
		1>$(WORK_DIR)/logs/_fight.txt 2>&1 & ); \
	echo "fight has been runned.."; sleep 2s;\
	($(WORK_DIR)/World -sessionAddrC $(SERVER_IP):$$SWL_PORT -dbAddrC $(DB_IP):$(DB_PORT) -worldId 200 -adminAddrL $(SERVER_IP):$$SAL_PORT \
		1>$(WORK_DIR)/logs/_social.txt 2>&1 & ); \
	echo "social has been runned.."; sleep 2s;\
