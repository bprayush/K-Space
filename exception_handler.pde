
boolean isInt(String str)
{
  try
  {
    int i = Integer.parseInt(str);
  }
  catch(NumberFormatException nfe)
  {
    return false;
  }
  return true;
}

boolean isFloat(String str)
{
  try
  {
    float i = Float.parseFloat(str);
  }
  catch(NumberFormatException nfe)
  {
    return false;
  }
  return true;
}

boolean isString(String str)
{
  try{
    str = str.substring(str.indexOf('B'), str.length());
  }
  catch(StringIndexOutOfBoundsException e)
  {
    return false;
  }
  return true;
}

boolean isChar(String str)
{
  try{
   // char[] c = str.substring(0,1).toCharArray();
  }
  catch(StringIndexOutOfBoundsException e)
  {
    return false;
  }
  return true;
}

boolean pointException(char c)
{
  try
  {
    if( c == 'R');
  }catch(NullPointerException npe)
  {
    return false;
  }
   return true;
}