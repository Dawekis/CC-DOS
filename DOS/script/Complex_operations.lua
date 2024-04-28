----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Complex = {};                        -- 定义一个名为Complex的table，用于存储复数相关的函数和方法
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Complex.new(r, i)           -- 定义Complex.new方法，用于创建一个新的复数对象
  return { r = r or 0, i = i or 0 }; -- 返回一个table，其中r表示实部（默认为0），i表示虚部（默认为0）
end
 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Complex.add(c1, c2)                    -- 定义Complex.add方法，用于计算两个复数的加法
  return Complex.new(c1.r + c2.r, c1.i + c2.i); -- 返回一个新的复数对象，其实部为两个复数实部的和，虚部为两个复数虚部的和
end
 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Complex.sub(c1, c2)                    -- 定义Complex.sub方法，用于计算两个复数的减法
  return Complex.new(c1.r - c2.r, c1.i - c2.i); -- 返回一个新的复数对象，其实部为第一个复数实部减去第二个复数实部，虚部为第一个复数虚部减去第二个复数虚部
end
 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Complex.mul(c1, c2)                                                -- 定义Complex.mul方法，用于计算两个复数的乘法
  return Complex.new(c1.r * c2.r - c1.i * c2.i, c1.r * c2.i + c1.i * c2.r); -- 返回一个新的复数对象，其实部为两个复数实部的乘积减去两个复数虚部的乘积，虚部为两个复数实部与虚部的乘积之和
end
 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Complex.div(c1, c2)                                                                                -- 定义Complex.div方法，用于计算两个复数的除法
  local denominator = c2.r ^ 2 + c2.i ^ 2                                                                   -- 定义分母
  return Complex.new((c1.r * c2.r + c1.i * c2.i) / denominator, (c1.i * c2.r - c1.r * c2.i) / denominator); --返回一个新的复数对象，其实部为两个复数实部的乘积减去两个复数虚部的乘积，虚部为两个复数实部与虚部的乘积之和
end
 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Complex.tostring(c)           -- 定义Complex.tostring方法，用于将复数对象转换为字符串形式
  if (c.i == 0) then                   -- 如果虚部为0
    return c.r;                        -- 返回实部
  elseif (c.r == 0) then               -- 如果实部为0
    return c.i .. "i";                 -- 返回虚部加上i的形式
  else
    if (c.i < 0) then                  -- 如果虚部小于0
      return c.r .. c.i .. "i";        -- 返回实部加上虚部加上i的形式
    else
      return c.r .. "+" .. c.i .. "i"; -- 返回实部加上+加上虚部加上i的形式
    end
  end
end
 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function SplitString(inputString)                                              -- 定义SplitString函数，用于将输入的字符串分割成单个字符或数字
  local result = {}                                                            -- 创建一个空的table，用于存储分割后的结果
  local currentIndex = 1                                                       -- 设置当前索引为1
  while currentIndex <= #inputString do                                        -- 当当前索引小于等于输入字符串的长度时执行循环
    local char = string.sub(inputString, currentIndex, currentIndex)           -- 获取当前索引位置的字符
    if char:match('%w') or char == '.' then                                    -- 如果字符是字母、数字或者点号
      local start, finish = string.find(inputString, "^[%w%.]+", currentIndex) -- 继续查找连续的字母、数字或者点号
      local substring = string.sub(inputString, start, finish)                 -- 获取连续的字符串
      table.insert(result, substring)                                          -- 将连续的字符串插入结果table中
      currentIndex = finish + 1                                                -- 更新当前索引为下一个字符的位置
    else
      table.insert(result, char)                                               -- 将单个字符插入结果table中
      currentIndex = currentIndex + 1                                          -- 更新当前索引为下一个字符的位置
    end
  end
  return result -- 返回分割后的结果table
end
 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function infixToPostfix(expression, i) -- 定义infixToPostfix函数，用于将中缀表达式转换为后缀表达式
  local operators = {                        -- 定义运算符的优先级
    ["+"] = 0,
    ["-"] = 0,
    ["*"] = 1,
    ["/"] = 1,
  };
  local postfix = {};                         -- 创建一个空的table，用于存储后缀表达式
  local stack = {};                           -- 创建一个空的table，用于存储运算符的栈
 
  local function popStackAndAppendToPostfix() -- 定义popStackAndAppendToPostfix函数，用于将栈中的运算符弹出并插入到后缀表达式中
    local top = table.remove(stack);          -- 弹出栈顶的运算符
    while (top) do                            -- 当栈不为空时执行循环
      table.insert(postfix, top);             -- 将弹出的运算符插入后缀表达式中
      top = table.remove(stack);              -- 继续弹出栈顶的运算符
    end
  end
 
  for token in expression:gmatch("%S+") do                                                                -- 遍历中缀表达式中的每个token
    local isOperator = operators[token];                                                                  -- 判断token是否为运算符
    if (isOperator) then                                                                                  -- 如果是运算符
      while (#stack > 0 and operators[stack[#stack]] and operators[token] <= operators[stack[#stack]]) do -- 当栈不为空且栈顶为运算符且当前运算符的优先级小于等于栈顶运算符的优先级时执行循环
        table.insert(postfix, table.remove(stack));                                                       -- 将栈顶的运算符弹出并插入到后缀表达式中
      end
      table.insert(stack, token);                                                                         -- 将当前运算符插入到栈中
    elseif (token) == "(" then                                                                            -- 如果是左括号
      table.insert(stack, token);                                                                         -- 将左括号插入到栈中
    elseif (token == ")") then                                                                            -- 如果是右括号
      local top = table.remove(stack);                                                                    -- 弹出栈顶的运算符
      while top and top ~= "(" do                                                                         -- 当栈顶不为空且栈顶不为左括号时执行循环
        table.insert(postfix, top);                                                                       -- 将弹出的运算符插入后缀表达式中
        top = table.remove(stack);                                                                        -- 继续弹出栈顶的运算符
      end
    else                                                                                                  -- 如果是数字或者其他字符
      table.insert(postfix, token);                                                                       -- 将token插入后缀表达式中
    end
  end
 
  popStackAndAppendToPostfix();        -- 将栈中剩余的运算符弹出并插入到后缀表达式中
  if (i) then                          -- 如果传入了第二个参数i
    return postfix;                    -- 返回后缀表达式的table形式
  else
    return table.concat(postfix, " "); -- 返回后缀表达式的字符串形式，每个token之间用空格分隔
  end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function calculatePostfix(expression)                 -- 定义calculatePostfix函数，用于计算后缀表达式结果
  local stack = {};                                         -- 创建一个空的table，用于存储操作数的栈
  for _, token in ipairs(expression) do                     -- 遍历后缀表达式中的每个token
    if (type(token) == "table") then                        -- 如果是复数对象
      table.insert(stack, token);                           -- 将复数对象插入栈中
    elseif (tonumber(token)) then                           -- 如果是数字
      table.insert(stack, Complex.new(tonumber(token), 0)); -- 将数字转换为复数对象并插入栈中
    else                                                    -- 如果是运算符
      local b = table.remove(stack);                        -- 弹出栈顶的操作数作为第二个运算数
      local a = table.remove(stack);                        -- 弹出栈顶的操作数作为第一个运算数
      if (token == "+") then                                -- 如果是加号
        table.insert(stack, Complex.add(a, b));             -- 将两个复数相加的结果插入栈中
      elseif (token == "-") then                            -- 如果是减号
        table.insert(stack, Complex.sub(a, b));             -- 将两个复数相减的结果插入栈中
      elseif (token == "*") then                            -- 如果是乘号
        table.insert(stack, Complex.mul(a, b));             -- 将两个复数相乘的结果插入栈中
      elseif (token == "/") then                            -- 如果是除号
        table.insert(stack, Complex.div(a, b));             -- 将两个复数相除的结果插入栈中
      else
        error("Unsupported operation: " .. token);          -- 抛出错误，表示不支持的运算符
      end
    end
  end
  return stack[1]; -- 返回栈中最后剩下的结果，即计算后的复数对象
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function FineTuning(t)                                        -- 定义FineTuning函数，用于对输入字符串进行微调，将虚部的数字字符串转换为复数对象
  local newS = {};                                                  -- 创建一个空的table，用于存储微调后的结果
  for _, value in pairs(t) do                                       -- 遍历输入字符串中的每个token
    if (value:find("(%d+)i")) then                                  -- 如果token中包含数字加上i的形式（例如3i）
      table.insert(newS, Complex.new(0, value:sub(1, #value - 1))); -- 将其转换为复数对象插入结果table中
    else
      table.insert(newS, value);                                    -- 否则直接插入到结果table中
    end
  end
  return newS; -- 返回微调后的结果table
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function StartIng(str)                          -- 定义StartIng函数，用于开始计算输入的表达式
  local result = table.concat(SplitString(str), " "); -- 将输入字符串分割成单个字符或数字，并用空格连接成一个新的字符串
  local result1 = infixToPostfix(result, true);       -- 将新的字符串转换为后缀表达式的table形式
  local result2 = FineTuning(result1);                -- 对后缀表达式的table进行微调，将虚部的数字字符串转换为复数对象
  return Complex.tostring(calculatePostfix(result2)); -- 计算后缀表达式的结果，并将结果转换为字符串形式返回
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Complex.calculator(str)
    local result = StartIng(str)
    return
    result
end
return
Complex

