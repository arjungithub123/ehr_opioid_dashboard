
DROP TABLE IF EXISTS cse523_schema."demographics"; 

CREATE TABLE IF NOT EXISTS cse523_schema."demographics" (
	"ROW_NUMBER" INT,
	"patient id" VARCHAR(100) COMPRESSION pglz,
	"gender" VARCHAR(50) COMPRESSION pglz,
	"age" INT, 
	"risk score" FLOAT,
	"risk label" VARCHAR(75) COMPRESSION pglz
);


COPY cse523_schema."demographics"(
    "ROW_NUMBER",
	"patient id",
	"gender", 
	"age",
	"risk score",
	"risk label"
)
FROM '/Users/arjun_ob/Documents/new_data_05:08/demographics_all1.csv' WITH (format csv, null " ", DELIMITER ',', HEADER);

ALTER TABLE cse523_schema."demographics" DROP COLUMN "ROW_NUMBER";

select * from cse523_schema."demographics" limit 100;

DROP TABLE IF EXISTS cse523_schema."diagnosis";
CREATE TABLE IF NOT EXISTS cse523_schema."diagnosis" (
	"ROW_NUMBER" INT,
	"patient id" VARCHAR(100) COMPRESSION pglz,
	"diagnosis" VARCHAR(255) COMPRESSION pglz,
	"shapley value" FLOAT
);


COPY cse523_schema."diagnosis"(
    "ROW_NUMBER",
	"patient id",
	"diagnosis", 
	"shapley value"
)
FROM '/Users/arjun_ob/Documents/new_data_05:08/diagnosis_final.csv' WITH (format csv, null " ", DELIMITER ',', HEADER);

ALTER TABLE cse523_schema."diagnosis" DROP COLUMN "ROW_NUMBER";


select * from cse523_schema."diagnosis" limit 100;


DROP TABLE IF EXISTS cse523_schema."medication";
CREATE TABLE IF NOT EXISTS cse523_schema."medication" (
	"ROW_NUMBER" INT,
	"patient id" VARCHAR(100) COMPRESSION pglz,
	"medication" VARCHAR(255) COMPRESSION pglz,
	"shapley value" FLOAT
);


COPY cse523_schema."medication"(
    "ROW_NUMBER",
	"patient id",
	"medication", 
	"shapley value"
)
FROM '/Users/arjun_ob/Documents/new_data_05:08/medication_final.csv' WITH (format csv, null " ", DELIMITER ',', HEADER);

ALTER TABLE cse523_schema."medication" DROP COLUMN "ROW_NUMBER";

select * from cse523_schema."medication" limit 100;

DROP TABLE IF EXISTS cse523_schema."MME time";
CREATE TABLE IF NOT EXISTS cse523_schema."MME time" (
	"ROW_NUMBER" INT,
	"patient id" VARCHAR(100) COMPRESSION pglz,
	"mme" FLOAT,
	"months before diagnosis" INT
);


COPY cse523_schema."MME time"(
    "ROW_NUMBER",
	"patient id",
	"mme", 
	"months before diagnosis"
)
FROM '/Users/arjun_ob/Documents/new_data_05:08/MME_time_dashboard.csv' WITH (format csv, null " ", DELIMITER ',', HEADER);

ALTER TABLE cse523_schema."MME time" DROP COLUMN "ROW_NUMBER";



CREATE INDEX dem_pid_idx ON cse523_schema."demographics" USING btree ("patient id");
CREATE INDEX mme_time_pid_idx ON cse523_schema."MME time"  USING btree ("patient id");
CREATE INDEX medication_pid_idx ON cse523_schema."medication" USING btree ("patient id");
CREATE INDEX diagnosis_idx ON cse523_schema."diagnosis" USING btree ("patient id");

CREATE INDEX risk_label_idx ON cse523_schema."demographics" USING btree ("risk label");
CREATE INDEX gender_idx ON cse523_schema."demographics" USING btree ("gender");

select * from cse523_schema."demographics" limit 100;

CREATE TABLE IF NOT EXISTS cse523_schema."summary" (
	"ROW_NUMBER" INT,
	"patient id" VARCHAR(100) COMPRESSION pglz,
	"gender" VARCHAR(50) COMPRESSION pglz,
	"age" INT, 
	"risk score" FLOAT,
	"risk label" VARCHAR(75) COMPRESSION pglz,
	"medication" VARCHAR(255) COMPRESSION pglz,
	"diagnosis" VARCHAR(255) COMPRESSION pglz,
	"summary" VARCHAR(255) COMPRESSION pglz
);


COPY cse523_schema."summary"(
    "ROW_NUMBER",
	"patient id",
	"gender", 
	"age",
	"risk score",
	"risk label",
	"medication",
	"diagnosis",
	"summary"
)
FROM '/Users/arjun_ob/Documents/summary.csv' WITH (format csv, null " ", DELIMITER ',', HEADER);

ALTER TABLE cse523_schema."summary" 
ALTER COLUMN summary TYPE VARCHAR(5000);

select * from cse523_schema."summary";
ALTER TABLE cse523_schema."summary" DROP COLUMN "ROW_NUMBER";

DROP TABLE IF EXISTS cse523_schema."history_diagnosis";
CREATE TABLE IF NOT EXISTS cse523_schema."history_diagnosis" (
	"ROW_NUMBER" INT,
	"patient id" VARCHAR(100) COMPRESSION pglz,
	"hepatitis_history" VARCHAR(50) COMPRESSION pglz,
	"chronic_history" VARCHAR(50) COMPRESSION pglz,
	"alcohol_history" VARCHAR(50) COMPRESSION pglz,
	"mental_history" VARCHAR(50) COMPRESSION pglz,
	"history" VARCHAR(1000) COMPRESSION pglz
);


COPY cse523_schema."history_diagnosis"(
    "ROW_NUMBER",
	"patient id",
	"hepatitis_history",
	"chronic_history",
	"alcohol_history",
	"mental_history",
	"history"
)
FROM '/Users/arjun_ob/Documents/history_diagnosis.csv' WITH (format csv, null " ", DELIMITER ',', HEADER);

select * from cse523_schema."history_diagnosis";
ALTER TABLE cse523_schema."history_diagnosis" DROP COLUMN "ROW_NUMBER";

select * from cse523_schema."history_diagnosis"
where lower(mental_history) = 'yes';


select * from cse523_schema."history_diagnosis" limit 100;

select * from cse523_schema."medication" limit 100;