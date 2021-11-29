# ALB
resource "aws_lb" "alb" {
  name               = "${local.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.public_subnet.ids

  tags = {
      Name = "${local.name}-alb"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_1.arn
  }

    default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_2.arn
  }

    default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_3.arn
  }
}

resource "aws_lb_target_group" "alb_tg_1" {
  name        = "${local.name}-alb-tg-1"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.vpc.id


    health_check {
      enabled             = true
      healthy_threshold   = 3
      interval            = 10
      matcher             = "200" 
      path                = "/index.html"
      port                = "traffic-port"
      protocol            = "HTTP"
      timeout             = 2
      unhealthy_threshold = 2
    }
}

resource "aws_lb_target_group_attachment" "alb_tg_ass_1" {
  target_group_arn = aws_lb_target_group.alb_tg_1.arn
  target_id        = module.web.ids[0]
  port             = 80
}

resource "aws_lb_target_group" "alb_tg_2" {
  name        = "${local.name}-alb-tg-2"
  port        = 81
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.vpc.id


    health_check {
      enabled             = true
      healthy_threshold   = 3
      interval            = 10
      matcher             = "200" 
      path                = "/index.html"
      port                = "traffic-port"
      protocol            = "HTTP"
      timeout             = 2
      unhealthy_threshold = 2
    }
}

resource "aws_lb_target_group_attachment" "alb_tg_ass_2" {
  target_group_arn = aws_lb_target_group.alb_tg_2.arn
  target_id        = module.web.ids[0]
  port             = 81
}

resource "aws_lb_target_group" "alb_tg_3" {
  name        = "${local.name}-alb-tg-3"
  port        = 82
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.vpc.id


    health_check {
      enabled             = true
      healthy_threshold   = 3
      interval            = 10
      matcher             = "200" 
      path                = "/healthcheck"
      port                = "traffic-port"
      protocol            = "HTTP"
      timeout             = 2
      unhealthy_threshold = 2
    }
}

resource "aws_lb_target_group_attachment" "alb_tg_ass_3" {
  target_group_arn = aws_lb_target_group.alb_tg_3.arn
  target_id        = module.web.ids[0]
  port             = 82
}

# NLB
resource "aws_lb" "nlb" {
  name               = "${local.name}-nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = module.web_subnet.ids

  tags = {
      Name = "${local.name}-nlb"
  }
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 8080
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg_1.arn
  }

    default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg_2.arn
  }

    default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg_3.arn
  }
}

resource "aws_lb_target_group" "nlb_tg_1" {
  name        = "${local.name}-nlb-tg"
  port        = 8080
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = aws_vpc.vpc.id


    health_check {
      enabled             = true
      healthy_threshold   = 3
      interval            = 5
      port                = "traffic-port"
      protocol            = "TCP"
      unhealthy_threshold = 3
    }
}

resource "aws_lb_target_group_attachment" "nlb_tg_ass_1" {
  target_group_arn = aws_lb_target_group.nlb_tg_1.arn
  target_id        = module.web.ids[0]
  port             = 8080
}

resource "aws_lb_target_group" "nlb_tg_2" {
  name        = "${local.name}-nlb-tg"
  port        = 8081
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = aws_vpc.vpc.id


    health_check {
      enabled             = true
      healthy_threshold   = 3
      interval            = 5
      port                = "traffic-port"
      protocol            = "TCP"
      unhealthy_threshold = 3
    }
}

resource "aws_lb_target_group_attachment" "nlb_tg_ass_2" {
  target_group_arn = aws_lb_target_group.nlb_tg_2.arn
  target_id        = module.web.ids[0]
  port             = 8081
}

resource "aws_lb_target_group" "nlb_tg_3" {
  name        = "${local.name}-nlb-tg"
  port        = 8082
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = aws_vpc.vpc.id


    health_check {
      enabled             = true
      healthy_threshold   = 3
      interval            = 5
      port                = "traffic-port"
      protocol            = "TCP"
      unhealthy_threshold = 3
    }
}

resource "aws_lb_target_group_attachment" "nlb_tg_ass_3" {
  target_group_arn = aws_lb_target_group.nlb_tg_3.arn
  target_id        = module.web.ids[0]
  port             = 8082
}