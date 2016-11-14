# 启动脚本

WORK_DIR = $(shell pwd)
$(info --current work dir is : $(WORK_DIR))

export LD_LIBRARY_PATH = $(WORK_DIR)

.PHONY : test
.PHONY : client server
.PHONY : _client _server
.PHONY : client_v server_v

.PHONY : all clean
.PHONY : session gateway world
.PHONY : _session _gateway _world
.PHONY : session_v gateway_v world_v

# 启动入口
test : _server _client
	@echo "--test client and server are running in background.."

all : _session _gateway _world
	@echo "--servers are running in background.."

clean :
	@set -e; ../../sh.d/kill_server
	@echo "--server is clean.."
	@sleep 3s


# 前台运行程序
client :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/test_client 172.16.2.220 20013 1>$(WORK_DIR)/logs/test_client.txt 2>&1

server :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/test_server 172.16.2.220 20013 1>$(WORK_DIR)/logs/test_server.txt 2>&1

session :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Session -loginAddr 172.16.2.220:20013 -gateAddr 172.16.2.220:2300 -worldAddr 172.16.2.220:2500 1>$(WORK_DIR)/logs/session.txt 2>&1

gateway :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Gateway -loginAddr 172.16.2.220:20015 -worldAddr 172.16.2.220:2700 -sessionAddr 172.16.2.220:2300 -gatewayId 0 1>$(WORK_DIR)/logs/gateway.txt 2>&1

world :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/World -sessionAddr 172.16.2.220:2500 -worldId 0 1>$(WORK_DIR)/logs/world.txt 2>&1


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
	( $(WORK_DIR)/Session -loginAddr 172.16.2.220:20013 -gateAddr 172.16.2.220:2300 -worldAddr 172.16.2.220:2500 1>$(WORK_DIR)/logs/_session.txt 2>&1 & ); \
	echo "Session has been runned.."; sleep 2s

_gateway :
	@set -e; ulimit -c unlimited; \
	( $(WORK_DIR)/Gateway -loginAddr 172.16.2.220:20015 -worldAddr 172.16.2.220:2700 -sessionAddr 172.16.2.220:2300 -gatewayId 0 1>$(WORK_DIR)/logs/_gateway.txt 2>&1 & ); \
	echo "Gateway 0 has been runned.."; sleep 2s

_gateway_1 :
	@set -e; ulimit -c unlimited; \
	( $(WORK_DIR)/Gateway -loginAddr 172.16.2.220:20017 -worldAddr 172.16.2.220:2900 -sessionAddr 172.16.2.220:2300 -gatewayId 1 1>$(WORK_DIR)/logs/_gateway_1.txt 2>&1 & ); \
	echo "Gateway 1 has been runned.."; sleep 2s

_world :
	@set -e; ulimit -c unlimited; \
	( $(WORK_DIR)/World -sessionAddr 172.16.2.220:2500 -worldId 0 1>$(WORK_DIR)/logs/_world.txt 2>&1 & ); \
	echo "World 0 has been runned.."; sleep 2s

_world_1 :
	@set -e; ulimit -c unlimited; \
	( $(WORK_DIR)/World -sessionAddr 172.16.2.220:2500 -worldId 1 1>$(WORK_DIR)/logs/_world_1.txt 2>&1 & ); \
	echo "World 1 has been runned.."; sleep 2s


# 用valgrind运行程序
client_v :
	@set -e; ulimit -c 0; \
	valgrind --log-file=$(WORK_DIR)/vlog/client_v.txt $(WORK_DIR)/test_client 172.16.2.220 20013

server_v :
	@set -e; ulimit -c 0; \
	valgrind --log-file=$(WORK_DIR)/vlog/server_v.txt $(WORK_DIR)/test_server 172.16.2.220 20013

session_v:
	@set -e; ulimit -c 0; \
	valgrind --log-file=$(WORK_DIR)/vlog/session_v.txt $(WORK_DIR)/Session -loginAddr 172.16.2.220:20013 -gateAddr 172.16.2.220:2300 -worldAddr 172.16.2.220:2500

gateway_v:
	@set -e; ulimit -c 0; \
	valgrind --log-file=$(WORK_DIR)/vlog/gateway_v.txt $(WORK_DIR)/Gateway -loginAddr 172.16.2.220:20015 -worldAddr 172.16.2.220:2700 -sessionAddr 172.16.2.220:2300 -gatewayId 0
	
world_v :
	@set -e; ulimit -c 0; \
	valgrind --log-file=$(WORK_DIR)/vlog/world_v.txt $(WORK_DIR)/World -sessionAddr 172.16.2.217:2500 -worldId 0
