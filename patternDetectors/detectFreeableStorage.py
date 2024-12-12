from slither.slither import Slither


def detect_freeable_storage(slither: Slither):
    """
    Detects if any storage variable can be freed.
    """
    results = []

    for contract in slither.contracts:
        result = {"analysis_type": "detect_freeable_storage", "contract_name":contract.name}
        storage_variables = [{"var_name":v.name,"var_type":str(v.type),"freeable_storage_bytes":v.type.storage_size[0]} for v in contract.variables if v.is_stored]
        if len(storage_variables) == 0:
            result["message"] = "No storage vars - no optimization required"
            results.append(result)
            continue
        result["storage_variables"] = storage_variables
        result["message"] = "Variables in storage can be freed with 'delete' command when not used anymore."
        results.append(result)

    return results