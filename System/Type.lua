-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/02/15 23:55
--- Description  : 类型对象
------------------------------------------------
---@class System.Type : System.Object
---@field New fun(name, protoType, baseProtoType)
local Type, base = class.extends("System.Type", System.Object)

function Type:constructor(name, protoType, baseProtoType)
    self.m_name = name
    self.m_protoType = protoType
    self.m_baseProtoType = baseProtoType
end

function Type:GetName()
    return self.m_name
end

function Type:Equals(targetType)
    return self.m_name == targetType.m_name
end

function Type:ToString()
    return self.m_name
end

---@return System.Type
function Type:GetBaseType()
    return gettype(self.m_baseProtoType)
end

---确定指定的对象是否是当前 Type 的实例（包含继承关系）。
---@param obj System.Object 目标对象
---@return boolean
function Type:IsInstanceOfType(obj)
    return obj:GetType():IsSubclassOf(self)
end

---确定当前 Type 是否派生自指定的 Type。
---@param type System.Type 指定类型
---@return boolean
function Type:IsSubclassOf(type)
    local proto = self

    --如果等于基类则返回，不等于则继续向基类查找
    while proto do
        if proto == type then
            return true
        else
            proto = proto:GetBaseType()
        end
    end

    return false
end

--补加Object的Type，与Type的Type
class.__appTypes["System.Object"] = Type.New("System.Object", System.Object)
class.__appTypes["System.Type"] = Type.New("System.Type", Type, System.Object)

return Type