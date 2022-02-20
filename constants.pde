// O. Mroz, Added basic constants from previous assignment, 3:30pm 22/03/2021
public final int FRAMERATE = 60;

public final int SCREEN_X = 1300;
public final int SCREEN_Y = 800;
public final int MARGIN = 30;
public final int NAVBAR_HEIGHT = 80;

public final int RESULTS_GRAPH_BOX_WIDTH = 600;
public final int RESULTS_GRAPH_BOX_HEIGHT = 310;

public final int MAP_BOX_WIDTH = 800;
public final int MAP_BOX_HEIGHT = 560;
public final int MAP_WIDTH = 700;
public final int MAP_HEIGHT = 500;

// O. Mroz, Added some RankingsList constants, 3:00pm 16/04/2021 
public final int INFO_BOX_WIDTH = 560;
public final int INFO_BOX_HEIGHT = 305;
public final int LINECHART_BOX_WIDTH = 560;
public final int LINECHART_BOX_HEIGHT = 340;

// O. Mroz, Added some RankingsList constants, 3:00pm 19/04/2021 
public final int RANKED_LIST_WIDTH = 600;
public final int RANKED_LIST_HEIGHT = 560;
public final int SCROLLBAR_OFFSET = 12;
public final int EACH_RANKINGS_FILTER_WIDTH = 304;
public final int EACH_RANKINGS_FILTER_HEIGHT = 40;
public final int SCROLLBAR_WIDTH = 25;

final int GO_TO_SEARCH_SCREEN = 1;
final int GO_TO_RANKING_SCREEN = 2;
final int GO_TO_RESULT_SCREEN = 3;
final int EVENT_NULL=0;
final int TEXT_WIDGET=54; // S. Cataluna added text widget event
final int SCROLL_BAR=99; // B. Paisley added an event for scrollbar, 21:53 08/04/2021

final color COLOR_WHITE = color(255);
final color COLOR_LIGHT_GREY = color(200);
final color COLOR_LIGHTER_GREY = color(240);
final color COLOR_DARK_GREY = color(100);
final color COLOR_DARKER_GREY = color(40);
final color COLOR_RED = color(211, 47, 47);
final color COLOR_GREEN = color(102, 187, 106);
final color COLOR_BLUE = color(3, 155, 229);
final color COLOR_BLACK = color(0);
final color COLOR_PINK = color(248, 187, 208);
final color COLOR_ORANGE = color(251, 192, 45);
final color COLOR_PURPLE = color(160, 32, 240);
final color COLOR_LIGHT_YELLOW = color(55, 241, 118);
final color COLOR_LIGHT_BROWN = color(188, 170, 164);
final color COLOR_TRANSPARENT = color(255, 255, 255, 0);

final color COLOR_BABY_BLUE = color(231, 242, 248);
final color COLOR_AQUAMARINE = color(116, 190, 203);
final color COLOR_SALMON = color(255, 163, 132);
final color COLOR_FREESIA = color(239, 231, 188);

final color COLOR_SPEARMINT = color(69, 176, 140);
final color COLOR_ROSE_QUARTZ = color(247, 202, 201);
final color COLOR_YELLOW = color(255, 255, 0);

// O. Mroz, Added colorSet for charts, 3:30pm 22/03/2021
final color[] CHART_COLORS = new color[]{color(0, 63, 92), color(88, 80, 141), color(188, 80, 144), color(255, 99, 97), color(255, 166, 0), color(217, 108, 106), color(100, 94, 137), color(170, 94, 139), color(217, 108, 106), color(217, 155, 38)};

// S. Cataluna added constants to be used when reading in file - 7:52pm 22/03/2021
public static int DATE_INDEX = 0;
public static int AREA_INDEX = 1;
public static int STATE_INDEX = 2;
public static int GEOID_INDEX = 3;
public static int CASES_INDEX = 4;
public static int COUNTRY_INDEX = 5;

// O. Mroz added constants for searching each state - 5:30pm 01/04/2021
public static final int SEARCH_ALABAMA = 4;
public static final int SEARCH_ALASKA = 5;
public static final int SEARCH_ARIZONA = 6 ;
public static final int SEARCH_ARKANSAS = 7;
public static final int SEARCH_CALIFORNIA = 8 ;
public static final int SEARCH_COLORADO = 9;
public static final int SEARCH_CONNECTICUT = 10 ;
public static final int SEARCH_DELAWARE = 11;
public static final int SEARCH_FLORIDA = 12;
public static final int SEARCH_GEORGIA = 13;
public static final int SEARCH_HAWAII = 14;
public static final int SEARCH_IDAHO = 15;
public static final int SEARCH_ILLINOIS = 16 ;
public static final int SEARCH_INDIANA = 17;
public static final int SEARCH_IOWA = 18;
public static final int SEARCH_KANSAS = 19;
public static final int SEARCH_KENTUCKY = 20;
public static final int SEARCH_LOUISIANA = 21;
public static final int SEARCH_MAINE = 22;
public static final int SEARCH_MARYLAND = 23 ;
public static final int SEARCH_MASSACHUSETTS = 24 ;
public static final int SEARCH_MICHIGAN = 25;
public static final int SEARCH_MINNESOTA = 26;
public static final int SEARCH_MISSISSIPPI = 27;
public static final int SEARCH_MISSOURI = 28;
public static final int SEARCH_MONTANA = 29;
public static final int SEARCH_NEBRASKA = 30;
public static final int SEARCH_NEVADA = 31;
public static final int SEARCH_NEW_HAMPSHIRE = 32 ;
public static final int SEARCH_NEW_JERSEY = 33;
public static final int SEARCH_NEW_MEXICO = 34;
public static final int SEARCH_NEW_YORK = 35;
public static final int SEARCH_NORTH_CAROLINA = 36 ;
public static final int SEARCH_NORTH_DAKOTA = 37;
public static final int SEARCH_OHIO = 38;
public static final int SEARCH_OKLAHOMA = 39 ;
public static final int SEARCH_OREGON = 40;
public static final int SEARCH_PENNSYLVANIA = 41 ;
public static final int SEARCH_RHODE_ISLAND = 42 ;
public static final int SEARCH_SOUTH_CAROLINA = 43 ;
public static final int SEARCH_SOUTH_DAKOTA = 44;
public static final int SEARCH_TENNESSEE = 45;
public static final int SEARCH_TEXAS = 46;
public static final int SEARCH_UTAH = 47;
public static final int SEARCH_VERMONT = 48;
public static final int SEARCH_VIRGINIA = 49;
public static final int SEARCH_WASHINGTON = 50;
public static final int SEARCH_WEST_VIRGINIA = 51;
public static final int SEARCH_WISCONSIN = 52;
public static final int SEARCH_WYOMING = 53;
