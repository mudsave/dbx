
SERVER_IP = 172.16.2.230
DB_IP = 172.16.2.230
DB_PORT = 3002

# 后台和前台启动 - 赵国君 30002
zgj_start: START_PORT=30002
zgj_start: start_server

zgj_session: START_PORT=30002
zgj_session : start_session
zgj_gateway: START_PORT=30002
zgj_gateway : start_gateway
zgj_world: START_PORT=30002
zgj_world : start_world
zgj_fight: START_PORT=30002
zgj_fight : start_fight
zgj_social: START_PORT=30002
zgj_social : start_social

# 后台和前台启动 - 李杰 31000
lj_start: START_PORT=31000
lj_start: start_server

lj_session: START_PORT=31000
lj_session : start_session
lj_gateway: START_PORT=31000
lj_gateway : start_gateway
lj_world: START_PORT=31000
lj_world : start_world
lj_fight: START_PORT=31000
lj_fight : start_fight
lj_social: START_PORT=31000
lj_social : start_social

# 后台和前台启动 - 贾伦 32000
jl_start: START_PORT=32000
jl_start: start_server

jl_session: START_PORT=32000
jl_session : start_session
jl_gateway: START_PORT=32000
jl_gateway : start_gateway
jl_world: START_PORT=32000
jl_world : start_world
jl_fight: START_PORT=32000
jl_fight : start_fight
jl_social: START_PORT=32000
jl_social : start_social

# 后台和前台启动 - 彭钱斌 33000
pqb_start: START_PORT=33000
pqb_start: start_server

pqb_session: START_PORT=33000
pqb_session : start_session
pqb_gateway: START_PORT=33000
pqb_gateway : start_gateway
pqb_world: START_PORT=33000
pqb_world : start_world
pqb_fight: START_PORT=33000
pqb_fight : start_fight
pqb_social: START_PORT=33000
pqb_social : start_social

# 后台和前台启动 - 陈敏 34000
cm_start: START_PORT=34000
cm_start: start_server

cm_session: START_PORT=34000
cm_session : start_session
cm_gateway: START_PORT=34000
cm_gateway : start_gateway
cm_world: START_PORT=34000
cm_world : start_world
cm_wdebug :
	@SCL_PORT=34000; \
	SWL_PORT=$$((SCL_PORT+2)); \
	set -e; ulimit -c unlimited; \
	gdb --args $(WORK_DIR)/World -sessionAddrC $(SERVER_IP):$$SWL_PORT -dbAddrC $(DB_IP):$(DB_PORT) -worldId 200
cm_fight: START_PORT=34000
cm_fight : start_fight
cm_social: START_PORT=34000
cm_social : start_social


# 后台和前台启动 - 康丽娟 35000
klj_start: START_PORT=35000
klj_start: start_server

klj_session: START_PORT=35000
klj_session : start_session
klj_gateway: START_PORT=35000
klj_gateway : start_gateway
klj_world: START_PORT=35000
klj_world : start_world
klj_fight: START_PORT=35000
klj_fight : start_fight
klj_social: START_PORT=35000
klj_social : start_social

# 后台和前台启动 - 龚爽 36000
gs_start: START_PORT=36000
gs_start: start_server

gs_session: START_PORT=36000
gs_session : start_session
gs_gateway: START_PORT=36000
gs_gateway : start_gateway
gs_world: START_PORT=36000
gs_world : start_world
gs_fight: START_PORT=36000
gs_fight : start_fight
gs_social: START_PORT=36000
gs_social : start_social

# 后台和前台启动 - 陈鸿乐 37000
chl_start: START_PORT=37000
chl_start: start_server

chl_session: START_PORT=37000
chl_session : start_session
chl_gateway: START_PORT=37000
chl_gateway : start_gateway
chl_world: START_PORT=37000
chl_world : start_world
chl_fight: START_PORT=37000
chl_fight : start_fight
chl_social: START_PORT=37000
chl_social : start_social

# 后台和前台启动 - 朱煌 38000
zh_start: START_PORT=38000
zh_start: start_server

zh_session: START_PORT=38000
zh_session : start_session
zh_gateway: START_PORT=38000
zh_gateway : start_gateway
zh_world: START_PORT=38000
zh_world : start_world
zh_fight: START_PORT=38000
zh_fight : start_fight
zh_social: START_PORT=38000
zh_social : start_social

# 后台和前台启动 - 舒清平 39010
sqp_start: START_PORT=39010
sqp_start: start_server

sqp_session: START_PORT=39010
sqp_session : start_session
sqp_gateway: START_PORT=39010
sqp_gateway : start_gateway
sqp_world: START_PORT=39010
sqp_world : start_world
sqp_fight: START_PORT=39010
sqp_fight : start_fight
sqp_social: START_PORT=39010
sqp_social : start_social

# 后台和前台启动 - 聂平安 39020
npa_start: START_PORT=39020
npa_start: start_server

npa_session: START_PORT=39020
npa_session : start_session
npa_gateway: START_PORT=39020
npa_gateway : start_gateway
npa_world: START_PORT=39020
npa_world : start_world
npa_fight: START_PORT=39020
npa_fight : start_fight
npa_social: START_PORT=39020
npa_social : start_social

# 后台和前台启动 - 袁哲 39030
yz_start: START_PORT=39030
yz_start: start_server

yz_session: START_PORT=39030
yz_session : start_session
yz_gateway: START_PORT=39030
yz_gateway : start_gateway
yz_world: START_PORT=39030
yz_world : start_world
yz_fight: START_PORT=39030
yz_fight : start_fight
yz_social: START_PORT=39030
yz_social : start_social

# 后台和前台启动 - 唐超 39040
tc_start: START_PORT=39040
tc_start: start_server

tc_session: START_PORT=39040
tc_session : start_session
tc_gateway: START_PORT=39040
tc_gateway : start_gateway
tc_world: START_PORT=39040
tc_world : start_world
tc_fight: START_PORT=39040
tc_fight : start_fight
tc_social: START_PORT=39040
tc_social : start_social

# 后台和前台启动 - 江钰 39050
jy_start: START_PORT=39050
jy_start: start_server

jy_session: START_PORT=39050
jy_session : start_session
jy_gateway: START_PORT=39050
jy_gateway : start_gateway
jy_world: START_PORT=39050
jy_world : start_world
jy_fight: START_PORT=39050
jy_fight : start_fight
jy_social: START_PORT=39050
jy_social : start_social

# 后台和前台启动 - 冯鹰 39060
fy_start: START_PORT=39060
fy_start: start_server

fy_session: START_PORT=39060
fy_session : start_session
fy_gateway: START_PORT=39060
fy_gateway : start_gateway
fy_world: START_PORT=39060
fy_world : start_world
fy_fight: START_PORT=39060
fy_fight : start_fight
fy_social: START_PORT=39060
fy_social : start_social

# 前台运行程序 - 程冲 39888
cc_start: START_PORT=39888
cc_start: start_server

cc_session: START_PORT=39888
cc_session : start_session
cc_gateway: START_PORT=39888
cc_gateway : start_gateway
cc_world: START_PORT=39888
cc_world : start_world
cc_fight: START_PORT=39888
cc_fight : start_fight
cc_social: START_PORT=39888
cc_social : start_social

# 前台运行程序 - 黄诗颉 39070
hsj_start: START_PORT=39070
hsj_start: start_server

hsj_session: START_PORT=39070
hsj_session : start_session
hsj_gateway: START_PORT=39070
hsj_gateway : start_gateway
hsj_world: START_PORT=39070
hsj_world : start_world
hsj_fight: START_PORT=39070
hsj_fight : start_fight
hsj_social: START_PORT=39070
hsj_social : start_social

# 前台运行程序 - 欧阳民振 39080
oymz_start: START_PORT=39080
oymz_start: start_server

oymz_session: START_PORT=39080
oymz_session : start_session
oymz_gateway: START_PORT=39080
oymz_gateway : start_gateway
oymz_world: START_PORT=39080
oymz_world : start_world
oymz_fight: START_PORT=39080
oymz_fight : start_fight
oymz_social: START_PORT=39080
oymz_social : start_social

# 前台运行程序 - 公共服务器 41000
dream_start: START_PORT=41000
dream_start: start_server

dream_session: START_PORT=41000
dream_session : start_session
dream_gateway: START_PORT=41000
dream_gateway : start_gateway
dream_world: START_PORT=41000
dream_world : start_world
dream_fight: START_PORT=41000
dream_fight : start_fight
dream_social: START_PORT=41000
dream_social : start_social

# 前台运行程序 - 熊鸿义 41010
xhy_start: START_PORT=41010
xhy_start: start_server

xhy_session: START_PORT=41010
xhy_session : start_session
xhy_gateway: START_PORT=41010
xhy_gateway : start_gateway
xhy_world: START_PORT=41010
xhy_world : start_world
xhy_fight: START_PORT=41010
xhy_fight : start_fight
xhy_social: START_PORT=41010
xhy_social : start_social


start_server:
	@SCL_PORT=$(START_PORT); \
	SGL_PORT=$$((SCL_PORT+1)); \
	SWL_PORT=$$((SCL_PORT+2)); \
	GCL_PORT=$$((SCL_PORT+3)); \
	GWL_PORT=$$((SCL_PORT+4)); \
	set -e; ulimit -c unlimited; \
	($(WORK_DIR)/Session -loginAddrL $(SERVER_IP):$$SCL_PORT -gateAddrL $(SERVER_IP):$$SGL_PORT -worldAddrL $(SERVER_IP):$$SWL_PORT -dbAddrC $(DB_IP):$(DB_PORT) \
		1>$(WORK_DIR)/logs/_session.txt 2>&1 & ); \
	echo "Session has been runned.."; sleep 2s;\
	($(WORK_DIR)/Gateway -loginAddrL $(SERVER_IP):$$GCL_PORT -worldAddrL $(SERVER_IP):$$GWL_PORT -sessionAddrC $(SERVER_IP):$$SGL_PORT -gatewayId 0 \
		1>$(WORK_DIR)/logs/_gateway.txt 2>&1 & ); \
	echo "gateway has been runned.."; sleep 2s;\
	($(WORK_DIR)/World -sessionAddrC $(SERVER_IP):$$SWL_PORT -dbAddrC $(DB_IP):$(DB_PORT) -worldId 0 \
		1>$(WORK_DIR)/logs/_world.txt 2>&1 & ); \
	echo "world has been runned.."; sleep 2s;\
	($(WORK_DIR)/World -sessionAddrC $(SERVER_IP):$$SWL_PORT -dbAddrC $(DB_IP):$(DB_PORT) -worldId 100 \
		1>$(WORK_DIR)/logs/_fight.txt 2>&1 & ); \
	echo "fight has been runned.."; sleep 2s;\
	($(WORK_DIR)/World -sessionAddrC $(SERVER_IP):$$SWL_PORT -dbAddrC $(DB_IP):$(DB_PORT) -worldId 200 \
		1>$(WORK_DIR)/logs/_social.txt 2>&1 & ); \
	echo "social has been runned.."; sleep 2s;\

start_session :
	@SCL_PORT=$(START_PORT); \
	SGL_PORT=$$((SCL_PORT+1)); \
	SWL_PORT=$$((SCL_PORT+2)); \
	set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Session -loginAddrL $(SERVER_IP):$$SCL_PORT -gateAddrL $(SERVER_IP):$$SGL_PORT -worldAddrL $(SERVER_IP):$$SWL_PORT -dbAddrC $(DB_IP):$(DB_PORT)
start_gateway :
	@SCL_PORT=$(START_PORT); \
	SGL_PORT=$$((SCL_PORT+1)); \
	GCL_PORT=$$((SCL_PORT+3)); \
	GWL_PORT=$$((SCL_PORT+4)); \
	set -e; ulimit -c unlimited; \
	$(WORK_DIR)/Gateway -loginAddrL $(SERVER_IP):$$GCL_PORT -worldAddrL $(SERVER_IP):$$GWL_PORT -sessionAddrC $(SERVER_IP):$$SGL_PORT -gatewayId 0
start_world :
	@SCL_PORT=$(START_PORT); \
	SWL_PORT=$$((SCL_PORT+2)); \
	set -e; ulimit -c unlimited; \
	$(WORK_DIR)/World -sessionAddrC $(SERVER_IP):$$SWL_PORT -dbAddrC $(DB_IP):$(DB_PORT) -worldId 0
start_fight :
	@SCL_PORT=$(START_PORT); \
	SWL_PORT=$$((SCL_PORT+2)); \
	set -e; ulimit -c unlimited; \
	$(WORK_DIR)/World -sessionAddrC $(SERVER_IP):$$SWL_PORT -dbAddrC $(DB_IP):$(DB_PORT) -worldId 100
start_social :
	@SCL_PORT=$(START_PORT); \
	SWL_PORT=$$((SCL_PORT+2)); \
	set -e; ulimit -c unlimited; \
	$(WORK_DIR)/World -sessionAddrC $(SERVER_IP):$$SWL_PORT -dbAddrC $(DB_IP):$(DB_PORT) -worldId 200
