using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Reflection;

namespace Oqtane.Extensions
{
    public static class StringExtensions
    {
        public static bool StartWithAnyOf(this string s, IEnumerable<string> list)
        {
            if (s == null)
            {
                return false;
            }

            return list.Any(f => s.StartsWith(f));
        }

        public static T ToEnum<T>(this string value)
        {
            T theEnum = default(T);

            Type enumType = typeof(T);

            //check and see if the value is a non attribute value
            try
            {
                theEnum = (T)Enum.Parse(enumType, value);
            }
            catch (ArgumentException)
            {
                bool found = false;
                foreach (T enumValue in Enum.GetValues(enumType))
                {
                    FieldInfo field = enumType.GetField(enumValue.ToString());

                    DescriptionAttribute attr = Attribute.GetCustomAttribute(field, typeof(DescriptionAttribute)) as DescriptionAttribute;

                    if (attr != null && attr.Description.Equals(value))
                    {
                        theEnum = enumValue;
                        found = true;
                        break;
                    }
                }

                if (!found)
                {
                    throw new ArgumentException("Cannot convert " + value + " to " + enumType.ToString());
                }
            }

            return theEnum;
        }
    }
}
