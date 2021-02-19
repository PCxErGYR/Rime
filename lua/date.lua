--[[
date_translator: 将 `date` 翻译为当前日期

translator 的功能是将分好段的输入串翻译为一系列候选项。

欲定义的 translator 包含三个输入参数：
 - input: 待翻译的字符串
 - seg: 包含 `start` 和 `_end` 两个属性，分别表示当前串在输入框中的起始和结束位置
 - env: 可选参数，表示 translator 所处的环境（本例没有体现）

translator 的输出是若干候选项。
与通常的函数使用 `return` 返回不同，translator 要求您使用 `yield` 产生候选项。

`yield` 每次只能产生一个候选项。有多个候选时，可以多次使用 `yield` 。

请看如下示例：
--]]

local function translator(input, seg)
   if (input == "date") then
      --- Candidate(type, start, end, text, comment)
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), ""))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), ""))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d"), ""))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y"), ""))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), ""))
  end
  if (input == "time") then
      --- Candidate(type, start, end, text, comment)
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), ""))
      yield(Candidate("time", seg.start, seg._end, os.date("%Y%m%d%H%M%S"), ""))
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), ""))
  end

  -- @JiandanDream
  -- https://github.com/KyleBing/rime-wubi86-jidian/issues/54

  if (input == "week") then
      local weakTab = {'日', '一', '二', '三', '四', '五', '六'}
      yield(Candidate("week", seg.start, seg._end, "周"..weakTab[tonumber(os.date("%w")+1)], ""))
      yield(Candidate("week", seg.start, seg._end, "星期"..weakTab[tonumber(os.date("%w")+1)], ""))
  end
end

-- 将上述定义导出
return translator
