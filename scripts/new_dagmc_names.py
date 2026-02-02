#!python

for (group_name, group_id) in cubit.group_names_ids():
    # ignore group "picked". It is always present by default and isn't
    # relevant for DAGMC metadata
    if group_name == 'picked':
        continue
    if not '_' in group_name:
        continue
    tokens = group_name.split('_')

    # require an even number of tokens so that they will pair correctly in
    # the properties identifier
    if len(tokens) % 2 != 0:
        print(f"Skipping group {group_id}: odd number of tokens in '{group_name}'")
        continue

    properties = [f'{p}:{v}' for p, v in zip(tokens[::2], tokens[1::2])]
    new_name = '/'.join(properties)
    print(f'Renaming group {group_id} to {new_name}')
    try:
        cubit.set_entity_name("Group", group_id, new_name)
        cubit.silent_cmd(f'group {group_id} rename "{new_name}"')
    except Exception as e:
        print(f"Failed to rename group {group_id}: {e}")

