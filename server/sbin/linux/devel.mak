

# 前台运行程序 - 赵国君 30000
zgj_session :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Session -loginAddrL 172.16.2.217:30000 -gateAddrL 172.16.2.217:30101 -worldAddrL 172.16.2.217:30102 -dbAddrC 172.16.4.159:3000
zgj_gateway :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Gateway -loginAddrL 172.16.2.217:30001 -worldAddrL 172.16.2.217:30103 -sessionAddrC 172.16.2.217:30101 -gatewayId 0
zgj_world :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/World -sessionAddrC 172.16.2.217:30102 -dbAddrC 172.16.4.159:3000 -worldId 0

# 前台运行程序 - 李杰 31000
lj_session :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Session -loginAddrL 172.16.2.217:31000 -gateAddrL 172.16.2.217:31101 -worldAddrL 172.16.2.217:31102 -dbAddrC 172.16.4.159:3000
lj_gateway :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Gateway -loginAddrL 172.16.2.217:31001 -worldAddrL 172.16.2.217:31103 -sessionAddrC 172.16.2.217:31101 -gatewayId 0
lj_world :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/World -sessionAddrC 172.16.2.217:31102 -dbAddrC 172.16.4.159:3000 -worldId 0

# 前台运行程序 - 贾伦 32000
jl_session :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Session -loginAddrL 172.16.2.217:32000 -gateAddrL 172.16.2.217:32101 -worldAddrL 172.16.2.217:32102 -dbAddrC 172.16.4.159:3000
jl_gateway :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Gateway -loginAddrL 172.16.2.217:32001 -worldAddrL 172.16.2.217:32103 -sessionAddrC 172.16.2.217:32101 -gatewayId 0
jl_world :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/World -sessionAddrC 172.16.2.217:32102 -dbAddrC 172.16.4.159:3000 -worldId 0

# 前台运行程序 - 彭钱斌 33000
pqb_session :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Session -loginAddrL 172.16.2.217:33000 -gateAddrL 172.16.2.217:33101 -worldAddrL 172.16.2.217:33102 -dbAddrC 172.16.4.159:3000
pqb_gateway :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Gateway -loginAddrL 172.16.2.217:33001 -worldAddrL 172.16.2.217:33103 -sessionAddrC 172.16.2.217:33101 -gatewayId 0
pqb_world :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/World -sessionAddrC 172.16.2.217:33102 -dbAddrC 172.16.4.159:3000 -worldId 0

# 前台运行程序 - 陈敏 34000
cm_session :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Session -loginAddrL 172.16.2.217:34000 -gateAddrL 172.16.2.217:34101 -worldAddrL 172.16.2.217:34102 -dbAddrC 172.16.4.159:3000
cm_gateway :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Gateway -loginAddrL 172.16.2.217:34001 -worldAddrL 172.16.2.217:34103 -sessionAddrC 172.16.2.217:34101 -gatewayId 0
cm_world :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/World -sessionAddrC 172.16.2.217:34102 -dbAddrC 172.16.4.159:3000 -worldId 0

# 前台运行程序 - 康丽娟 35000
klj_session :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Session -loginAddrL 172.16.2.217:35000 -gateAddrL 172.16.2.217:35101 -worldAddrL 172.16.2.217:35102 -dbAddrC 172.16.4.159:3000
klj_gateway :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Gateway -loginAddrL 172.16.2.217:35001 -worldAddrL 172.16.2.217:35103 -sessionAddrC 172.16.2.217:35101 -gatewayId 0
klj_world :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/World -sessionAddrC 172.16.2.217:35102 -dbAddrC 172.16.4.159:3000 -worldId 0

# 前台运行程序 - 龚爽 36000
gs_session :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Session -loginAddrL 172.16.2.217:36000 -gateAddrL 172.16.2.217:36101 -worldAddrL 172.16.2.217:36102 -dbAddrC 172.16.4.159:3000
gs_gateway :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Gateway -loginAddrL 172.16.2.217:36001 -worldAddrL 172.16.2.217:36103 -sessionAddrC 172.16.2.217:36101 -gatewayId 0
gs_world :
	@set -e; ulimit -c unlimited; \
	$(WORK_DIR)/World -sessionAddrC 172.16.2.217:36102 -dbAddrC 172.16.4.159:3000 -worldId 0
