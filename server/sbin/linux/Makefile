# 启动脚本

WORK_DIR = $(shell pwd)
$(info --current work dir is : $(WORK_DIR))

export LD_LIBRARY_PATH = $(WORK_DIR)

.PHONY : test
.PHONY : client server
.PHONY : _client _server
.PHONY : client_v server_v

.PHONY : all clean
.PHONY : session gateway world dbx
.PHONY : _session _gateway _world _fight _social _dbx
.PHONY : session_v gateway_v world_v dbx_v

# 启动入口
test : _server _client
	@echo "--test client and server are running in background.."

all : _session _gateway _world _fight _social
	@echo "--servers are running in background.."

clean :
	@set -e; ./kill_server
	@echo "--server is clean.."
	@sleep 3s


# 前台运行程序
client :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/test_client 172.16.2.220 20013

server :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/test_server 172.16.2.220 20013

session :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Session -loginAddrL 172.16.2.220:20013 -gateAddrL 172.16.2.220:2300 -worldAddrL 172.16.2.220:2500 -dbAddrC 172.16.4.159:3000

gateway :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Gateway -loginAddrL 172.16.2.220:20015 -worldAddrL 172.16.2.220:2700 -sessionAddrC 172.16.2.220:2300 -gatewayId 0

world :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/World -sessionAddrC 172.16.2.220:2500 -dbAddrC 172.16.4.159:3000 -worldId 0

fight :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/World -sessionAddrC 172.16.2.220:2500 -dbAddrC 172.16.4.159:3000 -worldId 100

fight_1 :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/World -sessionAddrC 172.16.2.220:2500 -dbAddrC 172.16.4.159:3000 -worldId 101

dbx :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/dbx

# 后台运行程序
_client :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/test_client 172.16.2.220 20013 1>$(WORK_DIR)/logs/_test_client.txt 2>&1 &

_server :
	@set -e; ulimit -c unlimited; \
	( $(WORK_DIR)/test_server 172.16.2.220 20013 1>$(WORK_DIR)/logs/_test_server.txt 2>&1 & ); \
	sleep 2s

_session :
	@set -e; ulimit -c unlimited; \
	( $(WORK_DIR)/Session -loginAddrL 172.16.2.218:20013 -gateAddrL 172.16.2.218:2300 -worldAddrL 172.16.2.218:2500 -dbAddrC 172.16.2.217:3007 1>$(WORK_DIR)/logs/_session.txt 2>&1 & ); \
	echo "Session has been runned.."; sleep 2s

_gateway :
	@set -e; ulimit -c unlimited; \
	( $(WORK_DIR)/Gateway -loginAddrL 172.16.2.218:20015 -worldAddrL 172.16.2.218:2700 -sessionAddrC 172.16.2.218:2300 -gatewayId 0 1>$(WORK_DIR)/logs/_gateway.txt 2>&1 & ); \
	echo "Gateway 0 has been runned.."; sleep 2s

_gateway_1 :
	@set -e; ulimit -c unlimited; \
	( $(WORK_DIR)/Gateway -loginAddrL 172.16.2.218:20017 -worldAddrL 172.16.2.218:2900 -sessionAddrC 172.16.2.218:2300 -gatewayId 1 1>$(WORK_DIR)/logs/_gateway_1.txt 2>&1 & ); \
	echo "Gateway 1 has been runned.."; sleep 2s

_world :
	@set -e; ulimit -c unlimited; \
	( $(WORK_DIR)/World -sessionAddrC 172.16.2.218:2500 -dbAddrC 172.16.2.217:3007 -worldId 0 -adminAddrL 172.16.2.218:2501 1>$(WORK_DIR)/logs/_world.txt 2>&1 & ); \
	echo "World 0 has been runned.."; sleep 2s

_world_1 :
	@set -e; ulimit -c unlimited; \
	( $(WORK_DIR)/World -sessionAddrC 172.16.2.218:2500 -dbAddrC 172.16.2.217:3007 -worldId 1 1>$(WORK_DIR)/logs/_world_1.txt 2>&1 & ); \
	echo "World 1 has been runned.."; sleep 2s
_fight :
	@set -e; ulimit -c unlimited; \
	( $(WORK_DIR)/World -sessionAddrC 172.16.2.218:2500 -dbAddrC 172.16.2.217:3007 -worldId 100 -adminAddrL 172.16.2.218:2502 1>$(WORK_DIR)/logs/_world100.txt 2>&1 & ); \
	echo "fight 100 has been runned.."; sleep 2s

_fight_1 :
	@set -e; ulimit -c unlimited; \
	( $(WORK_DIR)/World -sessionAddrC 172.16.2.218:2500 -dbAddrC 172.16.2.217:3007 -worldId 101 1>$(WORK_DIR)/logs/_world_101.txt 2>&1 & ); \
	echo "fight 101 has been runned.."; sleep 2s

_dbx :
	@set -e; ulimit -c unlimited; \
	( $(WORK_DIR)/dbx >$(WORK_DIR)/logs/_dbx.txt 2>&1 & ); \
	echo "dbx has been runned.."; sleep 2s

_social :
	@set -e; ulimit -c unlimited; \
	( $(WORK_DIR)/World -sessionAddrC 172.16.2.218:2500 -dbAddrC 172.16.2.217:3007 -worldId 200 -adminAddrL 172.16.2.218:2503 1>$(WORK_DIR)/logs/_world200.txt 2>&1 & ); \
	echo "social 200 has been runned.."; sleep 2s

# 用valgrind运行程序
client_v :
	@set -e; ulimit -c 0; \
	valgrind --log-file=$(WORK_DIR)/vlogs/client_v.txt $(WORK_DIR)/test_client 172.16.2.220 20013

server_v :
	@set -e; ulimit -c 0; \
	valgrind --log-file=$(WORK_DIR)/vlogs/server_v.txt $(WORK_DIR)/test_server 172.16.2.220 20013

session_v:
	@set -e; ulimit -c 0; \
	valgrind --log-file=$(WORK_DIR)/vlogs/session_v.txt $(WORK_DIR)/Session -loginAddrL 172.16.2.220:20013 -gateAddrL 172.16.2.220:2300 -worldAddrL 172.16.2.220:2500 -dbAddrC 172.16.4.159:3000

gateway_v:
	@set -e; ulimit -c 0; \
	valgrind --log-file=$(WORK_DIR)/vlogs/gateway_v.txt $(WORK_DIR)/Gateway -loginAddrL 172.16.2.220:20015 -worldAddrL 172.16.2.220:2700 -sessionAddrC 172.16.2.220:2300 -gatewayId 0

world_v :
	@set -e; ulimit -c 0; \
	valgrind --log-file=$(WORK_DIR)/vlogs/world_v.txt $(WORK_DIR)/World -sessionAddrC 172.16.2.220:2500 -dbAddrC 172.16.4.159:3000 -worldId 0

dbx_v :
	@set -e; ulimit -c 0; \
	valgrind --log-file=$(WORK_DIR)/vlogs/dbx_v.txt $(WORK_DIR)/dbx

include ./devel.mak
