//+------------------------------------------------------------------+
//| MultiFibonacci.mq4 |
//| TrexSina |
//| https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Trex_Sina"
#property strict
#property indicator_chart_window

//--- enum برای استایل‌ها (با نام‌های متفاوت)
enum ENUM_FIBO_LINE_STYLE
{
FIBO_STYLE_SOLID = 0, // خط پیوسته
FIBO_STYLE_DASH = 1, // خط چین
FIBO_STYLE_DOT = 2, // نقطه چین
FIBO_STYLE_DASHDOT = 3, // خط و نقطه
FIBO_STYLE_DASHDOTDOT = 4 // خط و دو نقطه
};

//--- تنظیمات عمومی
input bool ShowButtons = true; // نمایش دکمه‌ها
input int ButtonWidth = 80; // عرض دکمه‌ها
input int ButtonHeight = 20; // ارتفاع دکمه‌ها
input color ButtonColor = clrDodgerBlue; // رنگ دکمه‌ها
input color ButtonTextColor = clrWhite; // رنگ متن دکمه‌ها

//--- تنظیمات میانبرهای صفحه کلید
input string Fib1_Shortcut = "A"; // میانبر فیبو 1 (تک حرف)
input string Fib2_Shortcut = "B"; // میانبر فیبو 2 (تک حرف)
input string Fib3_Shortcut = "C"; // میانبر فیبو 3 (تک حرف)
input string Fib4_Shortcut = "D"; // میانبر فیبو 4 (تک حرف)
input string Fib5_Shortcut = "E"; // میانبر فیبو 5 (تک حرف)

//--- تنظیمات فیبوناچی 1
input string Fib1_Levels = "0|TP1;0.122222|R2;0.277778|;0.333333|R1;0.455556|;0.5|Half;0.625556|PVL;0.765556|ENL;0.875556|LPL2;1|;-0.111111|Hant;-0.155556|;-0.277778|G4;-0.333333|;-0.6|G5;-0.666667|;-1|TP2;-1.715556|ENDL1;-2.11|ENDL2;0.911111|;0.8|;0.666667|;0.965556|lpl1";
input color Fib1_Color = clrDodgerBlue;
input color Fib1_TextColor = clrBlack;
input color Fib1_LevelsColor = clrRed; // رنگ لول‌های فیبو 1
input ENUM_FIBO_LINE_STYLE Fib1_Style = FIBO_STYLE_SOLID; // استایل خطوط فیبو 1
input ENUM_FIBO_LINE_STYLE Fib1_LevelsStyle = FIBO_STYLE_SOLID; // استایل لول‌های فیبو 1
input int Fib1_Width = 1;
input int Fib1_LevelsWidth = 1; // ضخامت لول‌های فیبو 1
input bool Fib1_Reverse = false;
input bool Fib1_Ray = false; // حالت Ray برای فیبو 1

//--- تنظیمات فیبوناچی 2
input string Fib2_Levels = "0.0 | Level 0 ---%$ ; 0.33 | Level 33 ---%$ ; 0.66 | Level 66 ---%$ ; 1.0 | Level 1 ---%$";
input color Fib2_Color = clrRed;
input color Fib2_TextColor = clrDarkBlue;
input color Fib2_LevelsColor = clrGreen; // رنگ لول‌های فیبو 2
input ENUM_FIBO_LINE_STYLE Fib2_Style = FIBO_STYLE_DOT; // استایل خطوط فیبو 2
input ENUM_FIBO_LINE_STYLE Fib2_LevelsStyle = FIBO_STYLE_DASH; // استایل لول‌های فیبو 2
input int Fib2_Width = 1;
input int Fib2_LevelsWidth = 2; // ضخامت لول‌های فیبو 2
input bool Fib2_Reverse = false;
input bool Fib2_Ray = false; // حالت Ray برای فیبو 2

//--- تنظیمات فیبوناچی 3
input string Fib3_Levels = "0.0|Start;0.382|Retrace;0.618|Target;1.0|End";
input color Fib3_Color = clrGreen;
input color Fib3_TextColor = clrBlack;
input color Fib3_LevelsColor = clrBlue; // رنگ لول‌های فیبو 3
input ENUM_FIBO_LINE_STYLE Fib3_Style = FIBO_STYLE_DASH; // استایل خطوط فیبو 3
input ENUM_FIBO_LINE_STYLE Fib3_LevelsStyle = FIBO_STYLE_DOT; // استایل لول‌های فیبو 3
input int Fib3_Width = 1;
input int Fib3_LevelsWidth = 1; // ضخامت لول‌های فیبو 3
input bool Fib3_Reverse = false;
input bool Fib3_Ray = false; // حالت Ray برای فیبو 3

//--- تنظیمات فیبوناچی 4
input string Fib4_Levels = "0.0|Base;0.5|Half;1.0|Full;1.618|Golden";
input color Fib4_Color = clrOrange;
input color Fib4_TextColor = clrBlack;
input color Fib4_LevelsColor = clrPurple; // رنگ لول‌های فیبو 4
input ENUM_FIBO_LINE_STYLE Fib4_Style = FIBO_STYLE_SOLID; // استایل خطوط فیبو 4
input ENUM_FIBO_LINE_STYLE Fib4_LevelsStyle = FIBO_STYLE_SOLID; // استایل لول‌های فیبو 4
input int Fib4_Width = 2;
input int Fib4_LevelsWidth = 3; // ضخامت لول‌های فیبو 4
input bool Fib4_Reverse = false;
input bool Fib4_Ray = false; // حالت Ray برای فیبو 4

//--- تنظیمات فیبوناچی 5
input string Fib5_Levels = "0.0|Begin;0.25|Q1;0.5|Half;0.75|Q3;1.0|Complete";
input color Fib5_Color = clrPurple;
input color Fib5_TextColor = clrWhite;
input color Fib5_LevelsColor = clrOrange; // رنگ لول‌های فیبو 5
input ENUM_FIBO_LINE_STYLE Fib5_Style = FIBO_STYLE_DOT; // استایل خطوط فیبو 5
input ENUM_FIBO_LINE_STYLE Fib5_LevelsStyle = FIBO_STYLE_DASH; // استایل لول‌های فیبو 5
input int Fib5_Width = 1;
input int Fib5_LevelsWidth = 2; // ضخامت لول‌های فیبو 5
input bool Fib5_Reverse = false;
input bool Fib5_Ray = false; // حالت Ray برای فیبو 5

//--- متغیرهای جهانی
string ButtonNames[5] = {"Fib1_Btn", "Fib2_Btn", "Fib3_Btn", "Fib4_Btn", "Fib5_Btn"};
string FiboNames[5] = {"Fib1_", "Fib2_", "Fib3_", "Fib4_", "Fib5_"};
int CurrentBar = 0;
bool Initialized = false;
string objPrefix = "MF_";
int fiboCounters[5] = {0, 0, 0, 0, 0};

//--- متغیرهای جهانی برای ذخیره‌سازی سطوح
string g_fib_levels[5];

//+------------------------------------------------------------------+
//| تابع تبدیل enum به استایل واقعی |
//+------------------------------------------------------------------+
int FiboStyleToRealStyle(ENUM_FIBO_LINE_STYLE fiboStyle)
{
switch(fiboStyle)
{
case FIBO_STYLE_SOLID: return STYLE_SOLID;
case FIBO_STYLE_DASH: return STYLE_DASH;
case FIBO_STYLE_DOT: return STYLE_DOT;
case FIBO_STYLE_DASHDOT: return STYLE_DASHDOT;
case FIBO_STYLE_DASHDOTDOT: return STYLE_DASHDOTDOT;
}
return STYLE_SOLID;
}

//+------------------------------------------------------------------+
//| تابع تبدیل حرف به کد مجازی |
//+------------------------------------------------------------------+
int CharToVKCode(string ch)
{
if(StringLen(ch) != 1) return 0;

int charCode = StringGetCharacter(ch, 0);

// تبدیل به حرف بزرگ اگر حرف کوچک است
if(charCode >= 97 && charCode <= 122) // a-z
charCode -= 32; // تبدیل به A-Z

return charCode;
}

//+------------------------------------------------------------------+
//| تابع بررسی میانبر صفحه کلید |
//+------------------------------------------------------------------+
bool CheckShortcut(int shortcutVK, int lparam)
{
int keyCode = lparam & 0xFFFF;
int pressed = keyCode;

return (pressed == shortcutVK);
}

//+------------------------------------------------------------------+
//| تابع ایجاد دکمه |
//+------------------------------------------------------------------+
bool CreateButton(string name, string text, int x, int y, int width, int height,
color bgColor, color textColor, int fontSize = 8)
{
if(!ObjectCreate(0, name, OBJ_BUTTON, 0, 0, 0))
return false;

ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
ObjectSetInteger(0, name, OBJPROP_XSIZE, width);
ObjectSetInteger(0, name, OBJPROP_YSIZE, height);
ObjectSetInteger(0, name, OBJPROP_BGCOLOR, bgColor);
ObjectSetInteger(0, name, OBJPROP_COLOR, textColor);
ObjectSetInteger(0, name, OBJPROP_BORDER_COLOR, clrGray);
ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
ObjectSetInteger(0, name, OBJPROP_FONTSIZE, fontSize);
ObjectSetString(0, name, OBJPROP_TEXT, text);
ObjectSetString(0, name, OBJPROP_FONT, "Arial");

return true;
}

//+------------------------------------------------------------------+
//| تنظیم سطوح فیبوناچی |
//+------------------------------------------------------------------+
void SetFiboLevels(string fiboName, int fibIndex)
{
    // از متغیر جهانی برای سطوح استفاده کن
    string levels = g_fib_levels[fibIndex];
    color fibColor = clrBlack;
    color textColor = clrBlack;
    color levelsColor = clrBlack;
    int fibStyle = STYLE_SOLID;
    int fibWidth = 1;
    int levelsStyle = STYLE_SOLID;
    int levelsWidth = 1;
    bool reverse = false;
    bool rayMode = false;

    // مقداردهی اولیه متغیرها بر اساس فیبو انتخاب شده
    switch(fibIndex)
    {
        case 0:
            fibColor = Fib1_Color;
            textColor = Fib1_TextColor;
            fibStyle = FiboStyleToRealStyle(Fib1_Style);
            fibWidth = Fib1_Width;
            reverse = Fib1_Reverse;
            rayMode = Fib1_Ray;
            levelsColor = Fib1_LevelsColor;
            levelsStyle = FiboStyleToRealStyle(Fib1_LevelsStyle);
            levelsWidth = Fib1_LevelsWidth;
            break;
        case 1:
            fibColor = Fib2_Color;
            textColor = Fib2_TextColor;
            fibStyle = FiboStyleToRealStyle(Fib2_Style);
            fibWidth = Fib2_Width;
            reverse = Fib2_Reverse;
            rayMode = Fib2_Ray;
            levelsColor = Fib2_LevelsColor;
            levelsStyle = FiboStyleToRealStyle(Fib2_LevelsStyle);
            levelsWidth = Fib2_LevelsWidth;
            break;
        case 2:
            fibColor = Fib3_Color;
            textColor = Fib3_TextColor;
            fibStyle = FiboStyleToRealStyle(Fib3_Style);
            fibWidth = Fib3_Width;
            reverse = Fib3_Reverse;
            rayMode = Fib3_Ray;
            levelsColor = Fib3_LevelsColor;
            levelsStyle = FiboStyleToRealStyle(Fib3_LevelsStyle);
            levelsWidth = Fib3_LevelsWidth;
            break;
        case 3:
            fibColor = Fib4_Color;
            textColor = Fib4_TextColor;
            fibStyle = FiboStyleToRealStyle(Fib4_Style);
            fibWidth = Fib4_Width;
            reverse = Fib4_Reverse;
            rayMode = Fib4_Ray;
            levelsColor = Fib4_LevelsColor;
            levelsStyle = FiboStyleToRealStyle(Fib4_LevelsStyle);
            levelsWidth = Fib4_LevelsWidth;
            break;
        case 4:
            fibColor = Fib5_Color;
            textColor = Fib5_TextColor;
            fibStyle = FiboStyleToRealStyle(Fib5_Style);
            fibWidth = Fib5_Width;
            reverse = Fib5_Reverse;
            rayMode = Fib5_Ray;
            levelsColor = Fib5_LevelsColor;
            levelsStyle = FiboStyleToRealStyle(Fib5_LevelsStyle);
            levelsWidth = Fib5_LevelsWidth;
            break;
    }

    // پردازش سطوح
    string pairs[];
    int cnt = StringSplit(levels, ';', pairs);
    if(cnt > 0)
    {
        ObjectSetInteger(0, fiboName, OBJPROP_LEVELS, cnt);
        ObjectSetInteger(0, fiboName, OBJPROP_LEVELCOLOR, textColor);

        for(int i = 0; i < cnt; i++)
        {
            string pair[];
            StringSplit(pairs[i], '|', pair);

            double level = StrToDouble(pair[0]);
            string desc = (ArraySize(pair) > 1) ? pair[1] : "";

            ObjectSetDouble(0, fiboName, OBJPROP_LEVELVALUE, i, level);
            ObjectSetString(0, fiboName, OBJPROP_LEVELTEXT, i, desc);
            ObjectSetInteger(0, fiboName, OBJPROP_LEVELSTYLE, i, levelsStyle);
            ObjectSetInteger(0, fiboName, OBJPROP_LEVELWIDTH, i, levelsWidth);
        }
    }

    // تنظیم خصوصیات ظاهری
    ObjectSetInteger(0, fiboName, OBJPROP_COLOR, fibColor);
    ObjectSetInteger(0, fiboName, OBJPROP_STYLE, fibStyle);
    ObjectSetInteger(0, fiboName, OBJPROP_WIDTH, fibWidth);
    ObjectSetInteger(0, fiboName, OBJPROP_RAY, rayMode);
    ObjectSetInteger(0, fiboName, OBJPROP_BACK, true);

    // چاپ اطلاعات برای دیباگ
    Print("فیبوناچی ", fibIndex + 1, " - Ray Mode: ", rayMode, " - Levels: ", cnt,
          " - Levels Color: ", levelsColor, " - Levels Style: ", levelsStyle, " - Levels Width: ", levelsWidth);
}

//+------------------------------------------------------------------+
//| پاک کردن متن‌های پیش‌فرض سطوح |
//+------------------------------------------------------------------+
void ClearFiboLevelTexts(string fiboName)
{
int levels = (int)ObjectGetInteger(0, fiboName, OBJPROP_LEVELS);
for(int i = 0; i < levels; i++)
{
ObjectSetString(0, fiboName, OBJPROP_LEVELTEXT, i, "");
}
}

//+------------------------------------------------------------------+
//| ایجاد فیبوناچی |
//+------------------------------------------------------------------+
void CreateFibo(int buttonNumber)
{
string fiboName = "";
color fiboLineColor = clrGray;
bool rayMode = false;

// دریافت اطلاعات چارت
double visiblePriceMax = ChartGetDouble(0, CHART_PRICE_MAX);
double visiblePriceMin = ChartGetDouble(0, CHART_PRICE_MIN);
int visibleBars = (int)ChartGetInteger(0, CHART_VISIBLE_BARS);
int firstVisibleBar = (int)ChartGetInteger(0, CHART_FIRST_VISIBLE_BAR);

// محاسبه زمان‌ها - استفاده از 25% و 75% عرض visible چارت
datetime time1 = iTime(NULL, 0, firstVisibleBar - (int)(visibleBars * 0.25));
datetime time2 = iTime(NULL, 0, firstVisibleBar - (int)(visibleBars * 0.75));

// حالت 1: فیبوناچی با اندازه ثابت (25% از ارتفاع چارت)
double priceRange = visiblePriceMax - visiblePriceMin;
double price1 = visiblePriceMax - priceRange * 0.25; // نقطه شروع در 25% از بالا
double price2 = visiblePriceMin + priceRange * 0.25; // نقطه پایان در 25% از پایین

switch(buttonNumber)
{
case 1:
fiboName = StringFormat("%sFibo1_%d", objPrefix, fiboCounters[0]++);
fiboLineColor = Fib1_Color;
rayMode = Fib1_Ray;
break;
case 2:
fiboName = StringFormat("%sFibo2_%d", objPrefix, fiboCounters[1]++);
fiboLineColor = Fib2_Color;
rayMode = Fib2_Ray;
break;
case 3:
fiboName = StringFormat("%sFibo3_%d", objPrefix, fiboCounters[2]++);
fiboLineColor = Fib3_Color;
rayMode = Fib3_Ray;
break;
case 4:
fiboName = StringFormat("%sFibo4_%d", objPrefix, fiboCounters[3]++);
fiboLineColor = Fib4_Color;
rayMode = Fib4_Ray;
break;
case 5:
fiboName = StringFormat("%sFibo5_%d", objPrefix, fiboCounters[4]++);
fiboLineColor = Fib5_Color;
rayMode = Fib5_Ray;
break;
}

// ایجاد ابزار فیبوناچی
if(!ObjectCreate(0, fiboName, OBJ_FIBO, 0, time1, price1, time2, price2))
{
Print("خطا در ایجاد فیبوناچی: ", GetLastError());
return;
}

// --- شروع منطق جدید برای جلوگیری از قفل شدن رویدادها ---

// 1. ابتدا آبجکت را غیرقابل انتخاب کن
ObjectSetInteger(0, fiboName, OBJPROP_SELECTABLE, false);

// 2. تمام خصوصیات و سطوح را تنظیم کن
ObjectSetInteger(0, fiboName, OBJPROP_COLOR, fiboLineColor);
ObjectSetInteger(0, fiboName, OBJPROP_STYLE, STYLE_SOLID);
ObjectSetInteger(0, fiboName, OBJPROP_WIDTH, 2);
ObjectSetInteger(0, fiboName, OBJPROP_BACK, false);
ObjectSetInteger(0, fiboName, OBJPROP_RAY_RIGHT, rayMode);
SetFiboLevels(fiboName, buttonNumber - 1);

// 3. آن را از حالت انتخاب خارج کن (این مهم است)
ObjectSetInteger(0, fiboName, OBJPROP_SELECTED, false);

// 4. حالا دوباره آن را قابل انتخاب کن تا کاربر بتواند بعداً آن را ویرایش کند
ObjectSetInteger(0, fiboName, OBJPROP_SELECTABLE, true);

// --- پایان منطق جدید ---

Print("فیبوناچی ایجاد شد: ", fiboName, " - Ray: ", rayMode);
ChartRedraw();
}

//+------------------------------------------------------------------+
//| تابع اضافه کردن فیبو به مرکز چارت |
//+------------------------------------------------------------------+
void AddFibonacciToCenter(int fibIndex)
{
CreateFibo(fibIndex + 1);
}

//+------------------------------------------------------------------+
//| تابع اضافه کردن فیبو به موقعیت فعلی |
//+------------------------------------------------------------------+
void AddFibonacciToCurrent(int fibIndex)
{
CreateFibo(fibIndex + 1);
}

//+------------------------------------------------------------------+
//| تابع مخفی کردن دکمه‌ها |
//+------------------------------------------------------------------+
void HideButtons()
{
for(int i = 0; i < 5; i++)
{
if(ObjectFind(0, ButtonNames[i]) >= 0)
ObjectSetInteger(0, ButtonNames[i], OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
}
}

//+------------------------------------------------------------------+
//| تابع نمایش دکمه‌ها |
//+------------------------------------------------------------------+
void ShowButtons()
{
if(!ShowButtons) return;

for(int i = 0; i < 5; i++)
{
if(ObjectFind(0, ButtonNames[i]) >= 0)
ObjectSetInteger(0, ButtonNames[i], OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
}
}

//+------------------------------------------------------------------+
//| تابع مقداردهی اولیه |
//+------------------------------------------------------------------+
void Initialize()
{
// ایجاد دکمه‌ها
if(ShowButtons)
{
for(int i = 0; i < 5; i++)
{
int x = 10 + (i * (ButtonWidth + 5));
string buttonText = StringFormat("Fib %d (%s)", i + 1,
StringSubstr(Fib1_Shortcut + ";" + Fib2_Shortcut + ";" + Fib3_Shortcut + ";" + Fib4_Shortcut + ";" + Fib5_Shortcut,
i * 2, 1));
CreateButton(ButtonNames[i], buttonText,
x, 10, ButtonWidth, ButtonHeight,
ButtonColor, ButtonTextColor);
}
}

// چاپ میانبرهای فعال برای دیباگ
Print("میانبرهای فعال:");
Print("فیبو 1: ", Fib1_Shortcut, " -> ", CharToVKCode(Fib1_Shortcut));
Print("فیبو 2: ", Fib2_Shortcut, " -> ", CharToVKCode(Fib2_Shortcut));
Print("فیبو 3: ", Fib3_Shortcut, " -> ", CharToVKCode(Fib3_Shortcut));
Print("فیبو 4: ", Fib4_Shortcut, " -> ", CharToVKCode(Fib4_Shortcut));
Print("فیبو 5: ", Fib5_Shortcut, " -> ", CharToVKCode(Fib5_Shortcut));

Initialized = true;
Print("اندیکاتور MultiFibonacci با موفقیت بارگذاری شد");
}

//+------------------------------------------------------------------+
//| تابع پاکسازی |
//+------------------------------------------------------------------+
void Deinitialize()
{
// پاک کردن دکمه‌ها
for(int i = 0; i < 5; i++)
{
if(ObjectFind(0, ButtonNames[i]) >= 0)
ObjectDelete(0, ButtonNames[i]);
}
}

//+------------------------------------------------------------------+
//| تابع رویداد چارت |
//+------------------------------------------------------------------+
void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
// بررسی کلیک روی دکمه‌ها
if(id == CHARTEVENT_OBJECT_CLICK)
{
for(int i = 0; i < 5; i++)
{
if(sparam == ButtonNames[i])
{
AddFibonacciToCenter(i);
break;
}
}
}

// بررسی میانبرهای صفحه کلید (تک حرف)
if(id == CHARTEVENT_KEYDOWN)
{
int keyPressed = (int)lparam & 0xFFFF;

// تبدیل میانبرها به کد مجازی
static int fib1VK = CharToVKCode(Fib1_Shortcut);
static int fib2VK = CharToVKCode(Fib2_Shortcut);
static int fib3VK = CharToVKCode(Fib3_Shortcut);
static int fib4VK = CharToVKCode(Fib4_Shortcut);
static int fib5VK = CharToVKCode(Fib5_Shortcut);

// بررسی کلیدهای فشرده شده
if(keyPressed == fib1VK)
{
Print("میانبر فیبو 1 فعال شد");
AddFibonacciToCurrent(0);
}
else if(keyPressed == fib2VK)
{
Print("میانبر فیبو 2 فعال شد");
AddFibonacciToCurrent(1);
}
else if(keyPressed == fib3VK)
{
Print("میانبر فیبو 3 فعال شد");
AddFibonacciToCurrent(2);
}
else if(keyPressed == fib4VK)
{
Print("میانبر فیبو 4 فعال شد");
AddFibonacciToCurrent(3);
}
else if(keyPressed == fib5VK)
{
Print("میانبر فیبو 5 فعال شد");
AddFibonacciToCurrent(4);
}
}
}

//+------------------------------------------------------------------+
//| تابع اصلی اندیکاتور |
//+------------------------------------------------------------------+
int OnInit()
{
    string gv_name = "MF_State_" + IntegerToString(ChartID());
    string filename = "MultiFibo_Levels_" + IntegerToString(ChartID()) + ".txt";

    string input_levels[5];
    input_levels[0] = Fib1_Levels;
    input_levels[1] = Fib2_Levels;
    input_levels[2] = Fib3_Levels;
    input_levels[3] = Fib4_Levels;
    input_levels[4] = Fib5_Levels;

    // بررسی وضعیت اندیکاتور با استفاده از متغیر سراسری
    if (GlobalVariableCheck(gv_name) == false)
    {
        // اولین اجرا در این جلسه: متغیر را تنظیم کن و از فایل بخوان
        GlobalVariableSet(gv_name, 1);

        int handle = FileOpen(filename, FILE_READ);
        if (handle != INVALID_HANDLE)
        {
            Print("بارگذاری مجدد پلتفرم. در حال خواندن تنظیمات از فایل...");
            for (int i = 0; i < 5; i++)
            {
                if (FileIsEnding(handle)) break;
                g_fib_levels[i] = FileReadString(handle);
            }
            FileClose(handle);
        }
        else
        {
            Print("اولین اجرای اندیکاتور. در حال ایجاد فایل تنظیمات...");
            for (int i = 0; i < 5; i++) g_fib_levels[i] = input_levels[i];

            handle = FileOpen(filename, FILE_WRITE);
            if (handle != INVALID_HANDLE)
            {
                for (int i = 0; i < 5; i++) FileWriteString(handle, g_fib_levels[i] + "\r\n");
                FileClose(handle);
            }
        }
    }
    else
    {
        // اجرای مجدد در همان جلسه (تغییر تنظیمات توسط کاربر). مقادیر جدید را ذخیره کن
        Print("تنظیمات توسط کاربر تغییر کرد. در حال ذخیره مقادیر جدید...");
        for (int i = 0; i < 5; i++) g_fib_levels[i] = input_levels[i];

        int handle = FileOpen(filename, FILE_WRITE);
        if (handle != INVALID_HANDLE)
        {
            for (int i = 0; i < 5; i++) FileWriteString(handle, g_fib_levels[i] + "\r\n");
            FileClose(handle);
        }
    }

    Initialize();
    return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| تابع پاکسازی اندیکاتور |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    // اگر اندیکاتور از چارت حذف شد، متغیر سراسری وضعیت را پاک کن
    if (reason == REASON_REMOVE)
    {
        string gv_name = "MF_State_" + IntegerToString(ChartID());
        if (GlobalVariableCheck(gv_name))
        {
            GlobalVariableDel(gv_name);
            Print("متغیر وضعیت MultiFibonacci پاک شد.");
        }
    }
    Deinitialize();
}

//+------------------------------------------------------------------+
//| تابع محاسبه اندیکاتور |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total, const int prev_calculated,
const datetime &time[], const double &open[],
const double &high[], const double &low[],
const double &close[], const long &tick_volume[],
const long &volume[], const int &spread[])
{
if(!Initialized)
Initialize();

CurrentBar = rates_total;
return(rates_total);
}
//+------------------------------------------------------------------+