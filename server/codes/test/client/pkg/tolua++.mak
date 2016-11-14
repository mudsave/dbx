# tolua.mak
# from *.pkg to *.pkg.cpp

# 当前工作路径
WORK_DIR = $(shell pwd)
$(info --current work dir is : $(WORK_DIR))

# TOLUA_TOOL转换工具
TOLUA_TOOL = $(WORK_DIR)/../../../tolua++/bin/tolua++
$(info --tolua_tool is : $(TOLUA_TOOL))

# 相关联的pkg文件
PKGS = $(wildcard $(WORK_DIR)/*.pkg)
$(info --pkgs is : $(PKGS))

$(WORK_DIR)/../src/api4lua.pkg.cpp : $(PKGS)
	$(TOLUA_TOOL) -n api4lua -o $(WORK_DIR)/../api4lua.pkg.cpp api4lua.pkg
