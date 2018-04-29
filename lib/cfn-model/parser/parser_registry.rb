Dir["#{__dir__}/*_parser.rb"].each do |model|
  require "cfn-model/parser/#{File.basename(model, '.rb')}"
end

class ParserRegistry
  attr_reader :registry

  def initialize
    @registry = {
      'AWS::EC2::SecurityGroup' => SecurityGroupParser,
      'AWS::EC2::NetworkInterface' => Ec2NetworkInterfaceParser,
      'AWS::EC2::Instance' => Ec2InstanceParser,
      'AWS::ElasticLoadBalancing::LoadBalancer' => LoadBalancerParser,
      'AWS::ElasticLoadBalancingV2::LoadBalancer' => LoadBalancerV2Parser,
      'AWS::IAM::Group' => IamGroupParser,
      'AWS::IAM::User' => IamUserParser,
      'AWS::IAM::Role' => IamRoleParser,
      'AWS::IAM::Policy' => WithPolicyDocumentParser,
      'AWS::IAM::ManagedPolicy' => WithPolicyDocumentParser,
      'AWS::S3::BucketPolicy' => WithPolicyDocumentParser,
      'AWS::SNS::TopicPolicy' => WithPolicyDocumentParser,
      'AWS::SQS::QueuePolicy' => WithPolicyDocumentParser
    }
  end

  def self.instance
    if @instance.nil?
      @instance = ParserRegistry.new
    end
    @instance
  end

  # def add_parser(resource_name, parser)
  #   @registry[resource_name] = parser
  # end
end