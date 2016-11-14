# common.mak: 通用规则


# 确定输出文件名
ifeq ($(PROJECT_TYPE), lib)
	TARGET = lib$(TARGET_NAME).so
else
	TARGET = $(TARGET_NAME)
endif

TARGET_PATH = $(TARGET_DIR)/$(TARGET)

# 若没有指定目标文件列表，则把 SRC_DIR 目录下的所有源文件做为目标文件列表
ifndef OBJS
OBJS = $(patsubst $(SRC_DIR)/%.cpp, $(INT_DIR)/%.o, $(wildcard $(SRC_DIR)/*.cpp))
OBJS += $(patsubst $(SRC_DIR)/%.c, $(INT_DIR)/%.o, $(wildcard $(SRC_DIR)/*.c))
endif

# 首目标
target : $(TARGET_PATH)

# 链接所有obj文件
$(TARGET_PATH) : $(OBJS)
	$(CXX) -o $@ $(OBJS) $(_L_OP)

# 产生依赖关系文件
$(INT_DIR)/%.d : $(SRC_DIR)/%.cpp
	@set -e; mkdir -p $(INT_DIR); \
	$(CXX) -MM $(INCLUDE_DIR) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,$(INT_DIR)/\1.o $@ : ,g' < $@.$$$$ > $@; \
	[ -s $@ ] || rm -f $@; rm -f $@.$$$$

$(INT_DIR)/%.d : $(SRC_DIR)/%.c
	@set -e; mkdir -p $(INT_DIR); \
	$(CXX) -MM $(INCLUDE_DIR) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,$(INT_DIR)/\1.o $@ : ,g' < $@.$$$$ > $@; \
	[ -s $@ ] || rm -f $@; rm -f $@.$$$$

# 将依赖关系文件包含到makefile中
sinclude $(OBJS:.o=.d)

# 编译所有源文件
$(INT_DIR)/%.o : $(SRC_DIR)/%.cpp
	$(CXX) $(_C_OP) -o $@ $<
$(INT_DIR)/%.o : $(SRC_DIR)/%.c
	$(CXX) $(_C_OP) -o $@ $<

# 删除中间文件
clean : 
	rm -rf $(INT_DIR)


# 打印修改过的源文件
INCS = $(patsubst -I%, %, $(INCLUDE_DIR))
SRCS = $(wildcard $(SRC_DIR)/*.cpp)
SRCS += $(wildcard $(SRC_DIR)/*.c)
SRCS += $(foreach dir, $(INCS), $(wildcard $(dir)/*))

print : $(INT_DIR)/print

$(INT_DIR)/print : $(SRCS) 
	@for var in $?; do \
		echo $$var; \
	done
	@touch $(INT_DIR)/print
