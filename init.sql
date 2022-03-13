CREATE TABLE "ICICI_Bank__Current_Account__X__file"
(
    "serialNumber" text NOT NULL,
    "transactionId" text NOT NULL,
    "valueDate" text NOT NULL,
    "txnpostDate" text NOT NULL,
    "chequeNumber" text,
    "description" text NOT NULL,
    "direction" text NOT NULL,
    "transactionAmt" text NOT NULL,
    "balanceAmt" text NOT NULL,
    "accountNumber" text,
    CONSTRAINT ICICI_Bank__Current_Account__X__file_pkey PRIMARY KEY ("transactionId")
);

CREATE TABLE "ICICI_Bank__Current_Account__X__warehouse"
(
    "transactionId" text NOT NULL,
    "valueDate" text NOT NULL,
    "txnpostDate" text NOT NULL,
    "chequeNumber" text,
    "description" text NOT NULL,
    "direction" text NOT NULL,
    "transactionAmt" numeric NOT NULL,
    "balanceAmt" numeric NOT NULL,
    "accountNumber" text NOT NULL,
    "branch" text,
    CONSTRAINT ICICI_Bank__Current_Account__X__warehouse_pkey PRIMARY KEY ("transactionId")
);

CREATE TABLE "ICICI_Bank__Credit_Card__Coral_Visa__file"
(
    "date" text NOT NULL,
    "transactionNumber" text NOT NULL,
    "transactionInfo" text NOT NULL,
    "points" text NOT NULL,
    "valueAmount_O" text NOT NULL,
    "valueAmount_₹" text NOT NULL,
    "direction" text,
    CONSTRAINT ICICI_Bank__Credit_Card__Coral_Visa__file_pkey PRIMARY KEY ("transactionNumber")
);

CREATE TABLE "ICICI_Bank__Credit_Card__Coral_Visa__warehouse"
(
    "date" text NOT NULL,
    "transactionNumber" text NOT NULL,
    "transactionInfo" text NOT NULL,
    "points" numeric NOT NULL,
    "valueAmount_O" numeric NOT NULL,
    "valueAmount_₹" numeric NOT NULL,
    "direction" text NOT NULL,
    "accountNumber" text NOT NULL,
    CONSTRAINT ICICI_Bank__Credit_Card__Coral_Visa__warehouse_pkey PRIMARY KEY ("transactionNumber")
);
