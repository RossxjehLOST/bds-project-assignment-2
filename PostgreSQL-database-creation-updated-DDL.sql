CREATE SCHEMA IF NOT EXISTS bds;
SET SCHEMA 'bds';
REVOKE CREATE ON SCHEMA public FROM public;
DROP SCHEMA public;

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."type_of_computer"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "type_of_computer" (
  "id_type_of_computer" SERIAL NOT NULL,
  "type_of_device" VARCHAR(45) NOT NULL,
  "is_selection_valid" BOOL NOT NULL,
  "accesories" VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY ("id_type_of_computer")
  -- INDEX "id_type_of_computer_UNIQUE" ("id_type_of_computer" ASC))
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."accesories"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "accesories" (
  "id_accesories" SERIAL NOT NULL,
  "type_of_accesories" VARCHAR(45) NOT NULL,
  "is_selection_valid" BOOL NOT NULL,
  "fk_id_accesorries" INT NOT NULL,
  PRIMARY KEY ("id_accesories"),
  -- INDEX "id_accesories_UNIQUE" ("id_accesories" ASC),
 -- INDEX "fk_id_accesories_idx" ("fk_id_accesorries" ASC),
  CONSTRAINT "fk_id_accesories"
    FOREIGN KEY ("fk_id_accesorries")
    REFERENCES "type_of_computer" ("id_type_of_computer")
    ON DELETE CASCADE
    ON UPDATE NO ACTION
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."address"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "address" (
  "id_address" SERIAL NOT NULL,
  "city" VARCHAR(45) NOT NULL,
  "zip_code" VARCHAR(45) NOT NULL,
  "street" VARCHAR(45) NOT NULL,
  "home_number" VARCHAR(45) NOT NULL,
  "optional_information" VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY ("id_address")
  -- INDEX "id_address_UNIQUE" ("id_address" ASC))
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."person"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "person" (
  "id_person" SERIAL NOT NULL,
  "name" VARCHAR(45) NOT NULL,
  "surename" VARCHAR(45) NOT NULL,
  "email" VARCHAR(45) NOT NULL UNIQUE,
  "bio" VARCHAR(45) NULL DEFAULT NULL,
  "profile_picture" VARCHAR(45) NULL DEFAULT NULL,
  "is_student" BOOL NULL DEFAULT NULL,
  "is_vip" BOOL NULL DEFAULT NULL,
  "phone_number" INT NOT NULL,
  PRIMARY KEY ("id_person")
  -- INDEX "id_person_UNIQUE" ("id_person" ASC))
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."payment"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "payment" (
  "id_payment" SERIAL NOT NULL,
  "was_payment_succesfull" BOOL NOT NULL,
  "type_of_payment" VARCHAR(45) NOT NULL,
  "date_of_payment" DATE NOT NULL,
  "has_money_back_thing" BOOL NOT NULL,
  "fk_id_payment_person" INT NOT NULL,
  "amount_paid" INT,
  PRIMARY KEY ("id_payment"),
  -- INDEX "id_payment_UNIQUE" ("id_payment" ASC),
 -- INDEX "fk_id_payment_person_idx" ("fk_id_payment_person" ASC),
  CONSTRAINT "fk_id_payment_person"
    FOREIGN KEY ("fk_id_payment_person")
    REFERENCES "person" ("id_person")
    ON DELETE CASCADE
    ON UPDATE NO ACTION
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."shipping"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "shipping" (
  "id_shipping" SERIAL NOT NULL,
  "type_of_shipping" VARCHAR(45) NOT NULL,
  "was_payment_succesfull" BOOL NOT NULL,
  "expected_date_of_shipping" DATE NOT NULL,
  "company_that_will_ship_the_order" VARCHAR(45) NOT NULL,
  "is_address_valid" BOOL NOT NULL,
  "fk_id_shipping_payment" INT NOT NULL,
  "fk_id_shipping_address" INT NOT NULL,
  PRIMARY KEY ("id_shipping"),
  -- INDEX "id_shipping_UNIQUE" ("id_shipping" ASC),
 -- INDEX "fk_id_shipping_address_idx" ("fk_id_shipping_address" ASC),
 -- INDEX "fk_id_shipping_payment_idx" ("fk_id_shipping_payment" ASC),
  CONSTRAINT "fk_id_shipping_address"
    FOREIGN KEY ("fk_id_shipping_address")
    REFERENCES "address" ("id_address")
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT "fk_id_shipping_payment"
    FOREIGN KEY ("fk_id_shipping_payment")
    REFERENCES "payment" ("id_payment")
    ON DELETE CASCADE
    ON UPDATE NO ACTION
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."cart_info"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "cart_info" (
  "id_cart_info" SERIAL NOT NULL,
  "items" VARCHAR(45) NOT NULL,
  "has_valid_shiping" BOOL NOT NULL,
  "was_payment_succesfull" BOOL NOT NULL,
  "fk_id_cart_info_shipping" INT NOT NULL,
  "fk_id_cart_info_payment" INT NOT NULL,
  "fk_id_cart_info_person" INT NOT NULL,
  PRIMARY KEY ("id_cart_info"),
  -- INDEX "id_cart_info_UNIQUE" ("id_cart_info" ASC),
 -- INDEX "fk_if_cart_info_person_idx" ("fk_id_cart_info_person" ASC),
 -- INDEX "fk_id_cart_info_shipping_idx" ("fk_id_cart_info_shipping" ASC),
 -- INDEX "fk_id_cart_info_payment_idx" ("fk_id_cart_info_payment" ASC),
  CONSTRAINT "fk_id_cart_info_payment"
    FOREIGN KEY ("fk_id_cart_info_payment")
    REFERENCES "payment" ("id_payment")
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT "fk_id_cart_info_shipping"
    FOREIGN KEY ("fk_id_cart_info_shipping")
    REFERENCES "shipping" ("id_shipping")
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT "fk_if_cart_info_person"
    FOREIGN KEY ("fk_id_cart_info_person")
    REFERENCES "person" ("id_person")
    ON DELETE CASCADE
    ON UPDATE NO ACTION
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."feedback"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "feedback" (
  "id_feedback" SERIAL NOT NULL,
  "rate" TEXT NOT NULL,
  "how_to_get_a_in_bds" TEXT NOT NULL,
  "what_to_change" TEXT NULL DEFAULT NULL,
  "what_nice" TEXT NULL DEFAULT NULL,
  "fk_id_feedback" INT NOT NULL,
  PRIMARY KEY ("id_feedback"),
  -- INDEX "id_feedback_UNIQUE" ("id_feedback" ASC),
 -- INDEX "fk_id_feedback_idx" ("fk_id_feedback" ASC),
  CONSTRAINT "fk_id_feedback"
    FOREIGN KEY ("fk_id_feedback")
    REFERENCES "person" ("id_person")
    ON DELETE CASCADE
    ON UPDATE NO ACTION
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."login"
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS "login" (
  "id_login" SERIAL NOT NULL,
  "is_login_true" BOOL NOT NULL,
  "is_account_active" BOOL NOT NULL,
  "password" TEXT NULL DEFAULT NULL,
  PRIMARY KEY ("id_login")
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."notebook_type"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "notebook_type" (
  "id_notebook_type" SERIAL NOT NULL,
  "type_of_notebook" VARCHAR(45) NOT NULL,
  "has_charger" BOOL NOT NULL,
  "warranty" DATE NOT NULL,
  "has_os" BOOL NULL DEFAULT NULL,
  "fk_id_notebook_type" INT NOT NULL,
  PRIMARY KEY ("id_notebook_type"),
 -- INDEX "fk_id_notebook_type_idx" ("fk_id_notebook_type" ASC),
  -- INDEX "id_notebook_type_UNIQUE" ("id_notebook_type" ASC),
  CONSTRAINT "fk_id_notebook_type"
    FOREIGN KEY ("fk_id_notebook_type")
    REFERENCES "type_of_computer" ("id_type_of_computer")
    ON DELETE CASCADE
    ON UPDATE NO ACTION
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."pc_config"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "pc_config" (
  "id_pc_config" SERIAL NOT NULL,
  "type_of_tower" VARCHAR(45) NULL DEFAULT NULL,
  "prebuild" boolean NULL DEFAULT NULL,
  "is_selection_valid" BOOL NOT NULL,
  "fk_id_pc_config" INT NOT NULL,
  PRIMARY KEY ("id_pc_config"),
  -- INDEX "id_pc_config_UNIQUE" ("id_pc_config" ASC),
 -- INDEX "fk_id_pc_config__idx" ("fk_id_pc_config" ASC),
  CONSTRAINT "fk_id_pc_config_"
    FOREIGN KEY ("fk_id_pc_config")
    REFERENCES "type_of_computer" ("id_type_of_computer")
    ON DELETE CASCADE
    ON UPDATE NO ACTION
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."pc_parts"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "pc_parts" (
  "id_pc_parts" SERIAL NOT NULL,
  "cpu" VARCHAR(45) NOT NULL,
  "cpu_cooler" VARCHAR(45) NOT NULL,
  "ram" VARCHAR(45) NOT NULL,
  "motherboard" VARCHAR(45) NOT NULL,
  "storage" VARCHAR(45) NOT NULL,
  "gpu" VARCHAR(45) NOT NULL,
  "psu" VARCHAR(45) NOT NULL,
  "case" VARCHAR(45) NOT NULL,
  "has_os" BOOL NULL DEFAULT NULL,
  "is_selection_valid" BOOL NOT NULL,
  "fk_id_pc_parts" INT NOT NULL,
  PRIMARY KEY ("id_pc_parts"),
  -- INDEX "id_pc_parts_UNIQUE" ("id_pc_parts" ASC),
 -- INDEX "fk_id_pc_parts_idx" ("fk_id_pc_parts" ASC),
  CONSTRAINT "fk_id_pc_parts"
    FOREIGN KEY ("fk_id_pc_parts")
    REFERENCES "pc_config" ("id_pc_config")
    ON DELETE CASCADE
    ON UPDATE NO ACTION
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."pc_prebuild"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "pc_prebuild" (
  "id_pc_prebuild" SERIAL NOT NULL,
  "type_of_prebuild" VARCHAR(45) NOT NULL,
  "prebuild_company_name" VARCHAR(45) NOT NULL,
  "has_os" BOOL NOT NULL,
  "fk_id_pc_prebuild" INT NOT NULL,
  PRIMARY KEY ("id_pc_prebuild"),
  -- INDEX "id_pc_prebuild_UNIQUE" ("id_pc_prebuild" ASC),
 -- INDEX "fk_id_pc_prebuild_idx" ("fk_id_pc_prebuild" ASC),
  CONSTRAINT "fk_id_pc_prebuild"
    FOREIGN KEY ("fk_id_pc_prebuild")
    REFERENCES "pc_config" ("id_pc_config")
    ON DELETE CASCADE
    ON UPDATE NO ACTION
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."person_has_address"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "person_has_address" (
  "id_person" INT NOT NULL,
  "id_address" INT NOT NULL,
  "company_address" VARCHAR(45) NULL DEFAULT NULL,
  "personal_address" VARCHAR(45) NULL DEFAULT NULL,
 -- PRIMARY KEY ("id_person", "id_address"),
 -- INDEX "fk_id_address_idx" ("id_address" ASC),
  CONSTRAINT "fk_id_address"
    FOREIGN KEY ("id_address")
    REFERENCES "address" ("id_address")
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT "id_person"
    FOREIGN KEY ("id_person")
    REFERENCES "person" ("id_person")
    ON DELETE CASCADE
    ON UPDATE NO ACTION
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."person_has_login"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "person_has_login" (
  "id_person" INT NOT NULL,
  "id_login" INT NOT NULL,
  "last_time_account_loged_in" TIMESTAMP NOT NULL,
  --PRIMARY KEY ("id_person", "id_login"),
 -- INDEX "fk_id_person_idx" ("id_person" ASC),
 -- INDEX "fk_id_login_idx" ("id_login" ASC),
  CONSTRAINT "fk_id_login"
    FOREIGN KEY ("id_login")
    REFERENCES "login" ("id_login")
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT "fk_login_id_person"
    FOREIGN KEY ("id_person")
    REFERENCES "person" ("id_person")
    ON DELETE CASCADE
    ON UPDATE NO ACTION
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."roles"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "roles" (
  "id_roles" SERIAL NOT NULL,
  "type_of_role" VARCHAR(45) NOT NULL,
  PRIMARY KEY ("id_roles")
  -- INDEX "id_roles_UNIQUE" ("id_roles" ASC))
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."person_has_roles"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "person_has_roles" (
  "id_person" SERIAL NOT NULL,
  "id_roles" INT NOT NULL,
  "role_is_active" DATE NOT NULL,
  --PRIMARY KEY ("id_person", "id_roles"),
 -- INDEX "fk_id_roles_idx" ("id_roles" ASC),
  CONSTRAINT "fk_id_person"
    FOREIGN KEY ("id_person")
    REFERENCES "person" ("id_person")
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT "fk_id_roles"
    FOREIGN KEY ("id_roles")
    REFERENCES "roles" ("id_roles")
    ON DELETE CASCADE
    ON UPDATE NO ACTION
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."person_has_shipping"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "person_has_shipping" (
  "id_person" INT NOT NULL,
  "id_shipping" INT NOT NULL,
  --PRIMARY KEY ("id_person", "id_shipping"),
 -- INDEX "fk_id_shipping_idx" ("id_shipping" ASC),
  CONSTRAINT "fk_id_shipping"
    FOREIGN KEY ("id_shipping")
    REFERENCES "shipping" ("id_shipping")
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT "fk_something_id_person"
    FOREIGN KEY ("id_person")
    REFERENCES "person" ("id_person")
    ON DELETE CASCADE
    ON UPDATE NO ACTION
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."person_has_type_of_computer"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "person_has_type_of_computer" (
  "id_person" INT NOT NULL,
  "id_type_of_computer" INT NOT NULL,
  "optional" VARCHAR(45) NULL DEFAULT NULL,
  --PRIMARY KEY ("id_person", "id_type_of_computer"),
 -- INDEX "id_type_of_computer" ("id_type_of_computer" ASC),
  CONSTRAINT "fk_dsfsdfsdf_id_person"
    FOREIGN KEY ("id_person")
    REFERENCES "person" ("id_person")
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT "id_type_of_computer"
    FOREIGN KEY ("id_type_of_computer")
    REFERENCES "type_of_computer" ("id_type_of_computer")
    ON DELETE CASCADE
    ON UPDATE NO ACTION
--DEFAULT CHARACTER SET = latin1;
);

-- -----------------------------------------------------
-- Table "Schema MySQL-database-scheme-Zacek-and-Matas"."warranty"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "warranty" (
  "id_warranty" SERIAL NOT NULL,
  "is_warranty_valid" BOOL NOT NULL,
  "type_of_warranty" VARCHAR(45) NOT NULL,
  "expiration_date" DATE NOT NULL,
  "fk_id_warranty" INT NOT NULL,
  PRIMARY KEY ("id_warranty"),
  -- INDEX "id_warranty_UNIQUE" ("id_warranty" ASC),
 -- INDEX "fk_id_warranty_idx" ("fk_id_warranty" ASC),
  CONSTRAINT "fk_id_warranty"
    FOREIGN KEY ("fk_id_warranty")
    REFERENCES "person" ("id_person")
    ON DELETE CASCADE
    ON UPDATE NO ACTION
--DEFAULT CHARACTER SET = latin1;
);
