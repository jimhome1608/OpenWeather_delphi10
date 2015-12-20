unit classOpenWeather;

interface
uses System.JSON, System.Classes, System.SysUtils;

type

TOpenWeatherItem = class
  name: string;
  country: string;
  id: string;
  temp: string;
  pressure: string;
  humidity: string;
  temp_min: string;
  temp_max: string;
  main: string;
  description: string;
  lon: string;
  lat: string;
  wind_speed: string;
  wind_deg: string;
  sunrise: string;
  sunset: string;
  clouds: string;
  dt: string;
  last_updated: TDateTime;
  debug_text: TStringList;
  procedure clear;
  procedure clean;
  function loadFromJsonData(_json_date: string): integer;
  constructor create;
  destructor destroy;
end;

implementation


function UnixToDateTime(USec: Longint): TDateTime;
const
  UnixStartDate: TDateTime = 25569.0; // 01/01/1970
begin
  Result := (Usec / 86400) + UnixStartDate;
end;

{ TOpenWeatherItem }

procedure TOpenWeatherItem.clean;
begin
    name:= StringReplace(name, '"', '',[rfReplaceAll, rfIgnoreCase]);
    country:= StringReplace(country, '"', '',[rfReplaceAll, rfIgnoreCase]);
    id:= StringReplace(id, '"', '',[rfReplaceAll, rfIgnoreCase]);
    pressure:= StringReplace(pressure, '"', '',[rfReplaceAll, rfIgnoreCase]);
    humidity:= StringReplace(humidity, '"', '',[rfReplaceAll, rfIgnoreCase]);
    temp_min:= StringReplace(temp_min, '"', '',[rfReplaceAll, rfIgnoreCase]);
    temp_max:= StringReplace(temp_max, '"', '',[rfReplaceAll, rfIgnoreCase]);
    main:= StringReplace(main, '"', '',[rfReplaceAll, rfIgnoreCase]);
    description:= StringReplace(description, '"', '',[rfReplaceAll, rfIgnoreCase]);
    lon:= StringReplace(lon, '"', '',[rfReplaceAll, rfIgnoreCase]);
    lat:= StringReplace(lat, '"', '',[rfReplaceAll, rfIgnoreCase]);
    wind_speed:= StringReplace(wind_speed, '"', '',[rfReplaceAll, rfIgnoreCase]);
    wind_deg:= StringReplace(wind_deg, '"', '',[rfReplaceAll, rfIgnoreCase]);
    sunrise:= StringReplace(sunrise, '"', '',[rfReplaceAll, rfIgnoreCase]);
    sunset:= StringReplace(sunset, '"', '',[rfReplaceAll, rfIgnoreCase]);
    clouds:= StringReplace(clouds, '"', '',[rfReplaceAll, rfIgnoreCase]);
    dt:= StringReplace(dt, '"', '',[rfReplaceAll, rfIgnoreCase]);
end;

procedure TOpenWeatherItem.clear;
begin
  name:= '';
  country:= '';
  id:= '';
  temp:= '';
  pressure:= '';
  humidity:= '';
  temp_min:= '';
  temp_max:= '';
  main:= '';
  description:= '';
  lon:= '';
  lat:= '';
  wind_speed:= '';
  wind_deg:= '';
  sunrise:= '';
  sunset:= '';
  clouds:= '';
  dt:= '';
end;





constructor TOpenWeatherItem.create;
begin
   inherited;
   debug_text:= TStringList.Create;
end;

destructor TOpenWeatherItem.destroy;
begin
    debug_text.Free;
    inherited;
end;

function TOpenWeatherItem.loadFromJsonData(_json_date: string): integer;
var s: string;
    _JSONValue: TJSONValue;
    _JSONObject: TJSONObject;
    _JSONObject2: TJSONObject;
    _JSONPair: TJSONPair;
    _ParseResult: INTEGER;
    _responce: string;
    _value: string;
    _idx: integer;
    _pos: integer;
    _pair_count: integer;
begin
  try
      _JSONObject:=  TJSONObject.Create;
      _ParseResult := _JSONObject.Parse(BytesOf(_json_date ),0);
      debug_text.Clear;
      debug_text.Add('>>>> JSONObject.ToString >>>>>>>>>>>');
      debug_text.Add(Format('_ParseResult: %d',[_ParseResult]));
      debug_text.Add(Format('JSONObject.Count: %d',[_JSONObject.Count]));
      _pair_count:= _JSONObject.Count;
      for _idx:= 0 to  _pair_count-1 do begin
         _JSONPair:= _JSONObject.Pairs[_idx];
         _responce:= _JSONPair.JsonValue.ToSTring;
         _pos:=  pos('[',_responce);
         if _pos = 1 then begin
            delete(_responce,_pos,1);
            _pos:=  pos(']',_responce);
            if _pos > 0 then
              delete(_responce,_pos,1);
         end;
         _JSONObject.Parse(BytesOf(_responce),0);
      end;
      for _idx:= 0 to  _JSONObject.Count-1 do begin
           _JSONPair:= _JSONObject.Pairs[_idx];
           debug_text.Add(IntToSTr(_idx)+':Pairs: '+ _JSONPair.ToString);// _JSONPair.JsonValue.ToString);
      end;
      _JSONPair := _JSONObject.Get('name');
      if _JSONPair <> Nil  then  name:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('country');
      if _JSONPair <> Nil  then  country:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('country');
      if _JSONPair <> Nil  then  country:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('id');
      if _JSONPair <> Nil  then  id:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('temp');
      if _JSONPair <> Nil  then  temp:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('pressure');
      if _JSONPair <> Nil  then  pressure:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('humidity');
      if _JSONPair <> Nil  then  humidity:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('temp_min');
      if _JSONPair <> Nil  then  temp_min:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('temp_max');
      if _JSONPair <> Nil  then  temp_max:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('main');
      if _JSONPair <> Nil  then  main:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('description');
      if _JSONPair <> Nil  then  description:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('lon');
      if _JSONPair <> Nil  then  lon:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('lat');
      if _JSONPair <> Nil  then  lat:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('speed');
      if _JSONPair <> Nil  then  wind_speed:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('deg');
      if _JSONPair <> Nil  then  wind_deg:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('sunrise');
      if _JSONPair <> Nil  then  sunrise:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('sunset');
      if _JSONPair <> Nil  then  sunset:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('clouds');
      if _JSONPair <> Nil  then  clouds:=  _JSONPair.JSONValue.ToSTring;
      _JSONPair := _JSONObject.Get('dt');
      if _JSONPair <> Nil  then begin
         dt:=  _JSONPair.JSONValue.ToSTring;
         last_updated:=  UnixToDateTime(StrToIntDef(dt,0));
      end;

       clean;

  finally
      _JSONObject.free;
  end;

end;

end.
