{% snapshot salesperson_snapshot %}

{{

    config(
        target_schema='snapshot',
        unique_key='salesperson_id',
        strategy='timestamp',
        updated_at='last_update_ts',
        invalid_hard_deletes='True'
    )
}}


SELECT salesperson_id,
	salesperson_name,
	commission_rate,
	store_id,
	status,
	last_update_ts
FROM {{ source('raw_bi_car', 'SALESPERSON') }}

{% endsnapshot %}