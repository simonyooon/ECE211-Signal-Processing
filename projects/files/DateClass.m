classdef Date
    properties (Access = private)
        year 
        month
        day
    end
    properties (Constant)
        months = ["Jan", " Feb", "Mar", "Apr", "May", "Jun", "Jul","Aug", "Sep", "Oct", "Nov", "Dec"]
    end
    methods
        function obj = Date(datea)
            datea = split(datea, "/");
            obj.year = datea(3);
            obj.month = datea(1);
            obj.day = datea(2);
        end
        function date = datea(obj) 
            obj.month = str2double(obj.month);
            dateamonth = obj.months(obj.month);
            date = dateamonth + " " + obj.day + ", " + obj.year;
        end
    end
end