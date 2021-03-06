CREATE SCHEMA orange_produce;

CREATE TABLE orange_produce.users(
    id              bigserial,
    name            text NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE orange_produce.farms(
    id              bigserial,
    name            text NOT NULL,
    location        point NOT NULL,
    created_by      bigint REFERENCES orange_produce.users ON DELETE CASCADE,
    PRIMARY KEY (id)
);

CREATE TABLE orange_produce.farm_audit(
    id              bigint REFERENCES orange_produce.farms ON DELETE CASCADE,
    created_date    timestamptz NOT NULL,
    modified_date   timestamptz NOT NULL
);

CREATE TABLE orange_produce.fields(
    id              bigserial,
    name            text NOT NULL,
    contained_in    bigint REFERENCES orange_produce.farms ON DELETE CASCADE,
    created_by      bigint REFERENCES orange_produce.users ON DELETE CASCADE,
    PRIMARY KEY (id)
);

CREATE TABLE orange_produce.fields_audit(
    id              bigint REFERENCES orange_produce.fields ON DELETE CASCADE,
    created_date    timestamptz NOT NULL,
    modified_date   timestamptz NOT NULL
);

CREATE TABLE orange_produce.crops(
    id              bigserial,
    name            text NOT NULL,
    country         text,
    market_value    money NOT NULL,
    yield_time      integer NOT NULL,
    cost_per        money NOT NULL,
    created_by      bigint REFERENCES orange_produce.users ON DELETE CASCADE,
    PRIMARY KEY (id)
);

CREATE TABLE orange_produce.crops_audit(
    id              bigint REFERENCES orange_produce.crops ON DELETE CASCADE,
    created_date    timestamptz NOT NULL,
    modified_date   timestamptz NOT NULL
);

CREATE TABLE orange_produce.blocks(
    id              bigserial,
    name            text NOT NULL,
    contained_in    bigint REFERENCES orange_produce.fields ON DELETE CASCADE,
    created_by      bigint REFERENCES orange_produce.users ON DELETE CASCADE,
    crop           bigint REFERENCES orange_produce.crops ON DELETE CASCADE,
    PRIMARY KEY (id)
);

CREATE TABLE orange_produce.blocks_audit(
    id              bigint REFERENCES orange_produce.blocks ON DELETE CASCADE,
    created_date    timestamptz NOT NULL,
    modified_date   timestamptz NOT NULL
);

CREATE TABLE orange_produce.crop_swap_event(
    id              bigserial,
    previous_crop   bigint REFERENCES orange_produce.crops ON DELETE CASCADE,
    new_crop        bigint REFERENCES orange_produce.crops ON DELETE CASCADE,
    swap_date       timestamptz NOT NULL,
    created_by      bigint REFERENCES orange_produce.users ON DELETE CASCADE,
    PRIMARY KEY (id)
);

CREATE TABLE orange_produce.crop_event_audit(
    id              bigint REFERENCES orange_produce.crop_swap_event ON DELETE CASCADE,
    created_date    timestamptz NOT NULL,
    modified_date   timestamptz NOT NULL
);