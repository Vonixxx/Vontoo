{ username
, ... 
}:

{
 home-manager.users."${username}" = {
   programs.firefox = {
     policies = {
       ManagedBookmarks = [
         {
          toplevel_name = "Zalozky";
         }
         {
          name = "Seznam"; 
          url  = "seznam.cz";
         }
         {
          name = "FIO Banka"; 
          url  = "ib.fio.cz/ib/login";
         }
         {
          name = "Seznam Email"; 
          url  = "email.seznam.cz";
         }
         {
          name = "Datove Schranky"; 
          url  = "mojedatovaschranka.cz/portal/ISDS/seznamzprav/prijate";
         }
       ];
     };
   };
 };
}
