CREATE INDEX adveng on hits (advengineid);
CREATE INDEX regid  on hits (RegionID);
CREATE INDEX cid on hits (counterid);
CREATE INDEX eventtime on hits (eventtime);
CREATE INDEX eventdate on hits (eventdate);
CREATE INDEX mobile on hits (mobilephonemodel);
CREATE INDEX refresh on hits (isrefresh, dontcounthits);
CREATE INDEX resolutionwidth on hits (resolutionwidth);
CREATE INDEX search on hits (searchphrase);
CREATE INDEX userid on hits (userid);

CREATE INDEX useridsearch on hits (userid, searchphrase);
CREATE INDEX widcip on hits (watchid, clientip);
CREATE INDEX mobileuser on hits (MobilePhoneModel,UserID);
CREATE INDEX regionuser on hits (RegionID,UserID);

CREATE INDEX mobile2 on hits (mobilephonemodel) WHERE mobilephonemodel <> '';
CREATE INDEX search2 on hits (searchphrase) WHERE searchphrase <> '';

