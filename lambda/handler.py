import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    
    # Find all security groups
    sgs = ec2.describe_security_groups()['SecurityGroups']
    
    for sg in sgs:
        sg_id = sg['GroupId']
        for perm in sg.get('IpPermissions', []):
            from_port = perm.get('FromPort')
            to_port = perm.get('ToPort')
            ip_ranges = perm.get('IpRanges', [])
            
            # Check if SSH (22) or RDP (3389)
            if from_port in [22, 3389]:
                for ip_range in ip_ranges:
                    if ip_range.get('CidrIp') == '0.0.0.0/0':
                        # Remove the rule
                        print(f"Revoking {from_port} from 0.0.0.0/0 in {sg_id}")
                        ec2.revoke_security_group_ingress(
                            GroupId=sg_id,
                            IpPermissions=[{
                                'IpProtocol': perm['IpProtocol'],
                                'FromPort': from_port,
                                'ToPort': to_port,
                                'IpRanges': [{'CidrIp': '0.0.0.0/0'}]
                            }]
                        )
