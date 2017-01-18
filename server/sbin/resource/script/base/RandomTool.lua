--[[RandomTool.lua
                   _ooOoo_ 
                  o8888888o 
                  88" . "88 
                  (| -_- |) 
                  O\  =  /O 
               ____/`---'\____ 
             .'  \\|     |//  `. 
            /  \\|||  :  |||//  \ 
           /  _||||| -:- |||||-  \ 
           |   | \\\  -  /// |   | 
           | \_|  ''\---/''  |   | 
           \  .-\__  `-`  ___/-. / E
         ___`. .'  /--.--\  `. . __ 
      ."" '<  `.___\_<|>_/___.'  >'"". 
     | | :  `- \`.;`\ _ /`;.`/ - ` : | | 
     \  \ `-.   \_ __\ /__ _/   .-` /  / 
======`-.____`-.___\_____/___.-`____.-'====== 
                   `=---=' 
				程序员掷骰子
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
]]

--[[
	全局的参考、表中参考，以upvalue形式暂存
	通过减少对_G表和其它表的查询工作
	从而提高执行效率
]]
local math_random = math.random
local math_floor = math.floor

--[[
	创建分布式概率生成器
	param:
		distribution:输入参数，一个区间和权重的数组:[{from,to,weight},...]
	ret:
		function(from,to)->value，以distribution提供的概率分布，在from,to区间中取得一个随机数
]]
function CreateProbability(distribution)
	if not distribution then return nil end
	
	--按权重大小给区间分布排序
	table.sort(distribution,
		function(seg1,seg2)
			return seg1[3] < seg2[3]
		end
	)

	local totalWeight = 0			--总权重
	local totalSample = 0			--样本总数

	for _,t in ipairs(distribution) do	--遍历权重分布数据
		if totalSample < t[2] then totalSample = t[2] end	--找到样本总数
		t[3],totalWeight = totalWeight,totalWeight + t[3]	--创建分布
	end

	local mode = totalWeight<=1
	return function(head,tail)
		local diceValue = (mode and math_random() or math_random(totalWeight))	--取一个随机值
		local index =#distribution	--在分布梯田中找到锚点
		for idx,seg in ipairs(distribution) do
			if diceValue < seg[3] then
				index = idx - 1
				break
			end
		end
		local segment = distribution[index] --命中的区间
		return math_floor(
			head + (math_random(segment[2] - segment[1]) + segment[1])/totalSample * (tail - head)
			)
	end
end

--[[
	不重复随机取数组下标
]]
function NonRepeatIndex(prevSize)
	local size
	local array = {}

	local function reset()
		for index = 1,prevSize do
			array[index] = index
		end
		size = prevSize
	end

	local function indexer()
		if size < 1 then
			return 0
		end
		local r = math_random(size)
		local index = array[r]
		array[r] = array[size]
		size = size - 1
		return index
	end
	reset()
	return indexer,reset
end
