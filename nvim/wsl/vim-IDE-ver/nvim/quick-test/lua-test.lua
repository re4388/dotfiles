objects_metatable = {}
setmetatable(objects_metatable, {__mode = "k"})

top_class = {} -- Class Type繼承的類別，擁有一些僅有Class Type可以使用的方法。
function top_class:extends(super_class)
  -- extends關鍵字的處理
  -- 僅有Class Type可以使用
  assert(objects_metatable[self], "Must a Class")
  assert(objects_metatable[_ENV[super_class]], "Super Class Must a Class")
  getmetatable(self).__index = _ENV[super_class] -- 繼承
  return self
end

-- method: new - to create new object
function top_class:new(options)
  local object = options -- WARN: note: 這裡使用複製可能會更好。
  for k, v in pairs(self) do
    object[k] = options[k] or self[k]
  end

  setmetatable(object, objects_metatable[self]) -- 註冊物件使用的metatable。
  return object
end

function Class(class_name)
  assert(type(class_name) == "string", "class name must a string")

  local class = {}
  _ENV[class_name] = class -- regist to global environment
  setmetatable(
    class,
    {
      __name = "<" .. class_name .. ">",
      __index = top_class, -- 繼承top_class
      __call = function(self, options) -- 使class結構可以直接被呼叫，更新類別結構
        for k, v in pairs(options) do
          self[k] = v
        end
      end
    }
  )

  objects_metatable[class] = {
    __index = class, -- 使實例物件繼承類別(指定類別)
    __name = "<instance of " .. class_name .. ">"
  }

  return class
end

-- 以上基本把 Class、extends 等關鍵字的行為處理完畢，接著來建立實際類別看看
--

Class "YouTuber" {
  name = "<<YouTuber Name>>",
  youtube_channel = "https://youtube.com/"
}

Class "VTuber":extends "YouTuber" {
  name = "",
  age = 0,
  slogan = "...",
  say = function(self)
    print(self.name .. ": " .. self.slogan)
  end
}

Class "CoverVTuber":extends "VTuber" {
  company = "OVER株式会社"
}

------------------

print(YouTuber) --> <YouTuber>: 0x5622d8d7e290
print(VTuber) --> <VTuber>: 0x5622d8d63c10
print(CoverVTuber) --> <CoverVTuber>: 0x5622d8d8eb30

-- 接著來建立實例使用看看吧！

coco =
  CoverVTuber:new {
  name = "桐生ココ",
  age = 3501,
  birth = {month = 6, day = 17},
  slogan = "good morning mother f**ker"
}

peko =
  CoverVTuber:new {
  name = "兎田ぺこら",
  age = 111,
  birth = {month = 1, day = 12},
  slogan = "Peko↗ Peko↘ Peko↗ Peko↘ Peko↗ Peko↘～！?"
}

hahama =
  CoverVTuber:new {
  name = "赤井はあと",
  age = 16,
  birth = {month = 8, day = 10},
  slogan = "哈恰瑪恰瑪" -- https://www.youtube.com/watch?v=hvoBS-BzB3M
}

bneHu =
  CoverVTuber:new {
  name = "Ben Hu",
  age = 40,
  birth = {month = 12, day = 3},
  slogan = "hmmm..."
}

-----------

coco:say() --> 桐生ココ: good morning mother f**ker
peko:say() --> 兎田ぺこら: Peko↗ Peko↘ Peko↗ Peko↘ Peko↗ Peko↘～！?
hahama:say() --> 赤井はあと: 哈恰瑪恰瑪
benHu:say() -->
